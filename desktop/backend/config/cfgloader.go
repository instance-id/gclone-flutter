package config

import (
	"bufio"
	"bytes"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"fmt"
	"io"
	"io/ioutil"
	mathrand "math/rand"
	"strconv"
	"unicode/utf8"

	"golang.org/x/text/unicode/norm"

	"log"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"time"

	"github.com/instance-id/gclone_flutter/backend/config/obscure"
	"github.com/instance-id/gclone_flutter/backend/fs"
	"github.com/pkg/errors"

	"github.com/mitchellh/go-homedir"

	"golang.org/x/crypto/nacl/secretbox"

	"github.com/Unknwon/goconfig"
)

const (
	configFileName       = "rclone.conf"
	hiddenConfigFileName = "." + configFileName
	ConfigToken          = "token"
	ConfigClientID       = "client_id"
	ConfigClientSecret   = "client_secret"
	ConfigAuthURL        = "auth_url"
	ConfigTokenURL       = "token_url"
	ConfigAuthorize      = "config_authorize"
)

var (
	CfgData                       = configFile
	configFile                    *goconfig.ConfigFile
	ConfigPath                    = makeConfigPath()
	configKey                     []byte
	PassConfigKeyForDaemonization = false
	PasswordPromptOutput          = os.Stderr
)

var errorConfigFileNotFound = errors.New("config file not found")

func getConfigData() *goconfig.ConfigFile {
	if configFile == nil {
		LoadConfig()
	}
	return configFile
}

// --- Load config Data ---------------------------------------------------------------------------
func LoadConfig() *goconfig.ConfigFile {
	// Load configuration file.
	var err error
	configFile, err = loadConfigFile()
	if err == errorConfigFileNotFound {
		//Logf(nil, "Config file %q not found - using defaults", ConfigPath)
		configFile, _ = goconfig.LoadFromReader(&bytes.Buffer{})
	} else if err != nil {
		log.Fatalf("Failed to load config file %q: %v", ConfigPath, err)
	} else {
		//log.Printf("Using config file from %q", ConfigPath)
	}

	return configFile
}

func loadConfigFile() (*goconfig.ConfigFile, error) {
	envpw := os.Getenv("RCLONE_CONFIG_PASS")
	if len(configKey) == 0 && envpw != "" {
		err := setConfigPassword(envpw)
		if err != nil {
			//log.Printf("Using RCLONE_CONFIG_PASS returned: %v", err)
		} else {
			//log.Printf("Using RCLONE_CONFIG_PASS password.")
		}
	}

	b, err := ioutil.ReadFile(ConfigPath)
	if err != nil {
		if os.IsNotExist(err) {
			return nil, errorConfigFileNotFound
		}
		return nil, err
	}
	// Find first non-empty line
	r := bufio.NewReader(bytes.NewBuffer(b))
	for {
		line, _, err := r.ReadLine()
		if err != nil {
			if err == io.EOF {
				return goconfig.LoadFromReader(bytes.NewBuffer(b))
			}
			return nil, err
		}
		l := strings.TrimSpace(string(line))
		if len(l) == 0 || strings.HasPrefix(l, ";") || strings.HasPrefix(l, "#") {
			continue
		}
		// First non-empty or non-comment must be ENCRYPT_V0
		if l == "RCLONE_ENCRYPT_V0:" {
			break
		}
		if strings.HasPrefix(l, "RCLONE_ENCRYPT_V") {
			return nil, errors.New("unsupported configuration encryption - update rclone for support")
		}
		return goconfig.LoadFromReader(bytes.NewBuffer(b))
	}

	// Encrypted content is base64 encoded.
	dec := base64.NewDecoder(base64.StdEncoding, r)
	box, err := ioutil.ReadAll(dec)
	if err != nil {
		return nil, errors.Wrap(err, "failed to load base64 encoded data")
	}
	if len(box) < 24+secretbox.Overhead {
		return nil, errors.New("Configuration data too short")
	}

	var out []byte
	for {
		if envKeyFile := os.Getenv("_RCLONE_CONFIG_KEY_FILE"); len(envKeyFile) > 0 {
			//TODO: LOGS
			log.Printf("attempting to obtain configKey from temp file %s", envKeyFile)
			obscuredKey, err := ioutil.ReadFile(envKeyFile)
			if err != nil {
				errRemove := os.Remove(envKeyFile)
				if errRemove != nil {
					log.Fatalf("unable to read obscured config key and unable to delete the temp file: %v", err)
				}
				log.Fatalf("unable to read obscured config key: %v", err)
			}
			errRemove := os.Remove(envKeyFile)
			if errRemove != nil {
				log.Fatalf("unable to delete temp file with configKey: %v", err)
			}
			configKey = []byte(obscure.MustReveal(string(obscuredKey)))
			log.Printf("using _RCLONE_CONFIG_KEY_FILE for configKey")
		} else {
			if len(configKey) == 0 {
				if !fs.Config.AskPassword {
					return nil, errors.New("unable to decrypt configuration and not allowed to ask for password - set RCLONE_CONFIG_PASS to your configuration password")
				}
				getConfigPassword("Enter configuration password:")
			}
		}

		// Nonce is first 24 bytes of the ciphertext
		var nonce [24]byte
		copy(nonce[:], box[:24])
		var key [32]byte
		copy(key[:], configKey[:32])

		// Attempt to decrypt
		var ok bool
		out, ok = secretbox.Open(nil, box[24:], &nonce, &key)
		if ok {
			break
		}

		// Retry
		log.Printf("Couldn't decrypt configuration, most likely wrong password.")
		configKey = nil
	}
	return goconfig.LoadFromReader(bytes.NewBuffer(out))
}

// FileGet gets the config key under section returning the
// default or empty string if not set.
//
// It looks up defaults in the environment if they are present
func FileGet(section, key string, defaultVal ...string) string {
	envKey := fs.ConfigToEnv(section, key)
	newValue, found := os.LookupEnv(envKey)
	if found {
		defaultVal = []string{newValue}
	}
	return getConfigData().MustValue(section, key, defaultVal...)
}

// FileGetFresh reads the config key under section return the value or
// an error if the config file was not found or that value couldn't be
// read.
func FileGetFresh(section, key string) (value string, err error) {
	reloadedConfigFile, err := loadConfigFile()
	if err != nil {
		return "", err
	}
	return reloadedConfigFile.GetValue(section, key)
}

// --- Display Data  ------------------------------------------------------------------------------

// ShowConfigLocation prints the location of the config file in use
func ShowConfigLocation() {
	if _, err := os.Stat(ConfigPath); os.IsNotExist(err) {
		fmt.Println("Configuration file doesn't exist, but rclone will use this path:")
	} else {
		fmt.Println("Configuration file is stored at:")
	}
	fmt.Printf("%s\n", ConfigPath)
}

// ShowConfig prints the (unencrypted) config options
func ShowConfig() {
	var buf bytes.Buffer
	if err := goconfig.SaveConfigData(getConfigData(), &buf); err != nil {
		log.Fatalf("Failed to serialize config: %v", err)
	}
	str := buf.String()
	if str == "" {
		str = "; empty config\n"
	}
	fmt.Printf("%s", str)
}

// ShowRemotes shows an overview of the config file
func ShowRemotes() {
	remotes := getConfigData().GetSectionList()
	if len(remotes) == 0 {
		return
	}
	sort.Strings(remotes)
	fmt.Printf("%-20s %s\n", "Name", "Type")
	fmt.Printf("%-20s %s\n", "====", "====")
	for _, remote := range remotes {
		fmt.Printf("%-20s %s\n", remote, FileGet(remote, "type"))
	}
}

// ShowRemotes shows an overview of the config file
func GetRemotes() (*goconfig.ConfigFile, []string) {
	remotes := getConfigData().GetSectionList()
	if len(remotes) == 0 {
		return getConfigData(), nil
	}
	sort.Strings(remotes)
	return getConfigData(), remotes
}

// ChooseRemote chooses a remote name
func ChooseRemote() string {
	remotes := getConfigData().GetSectionList()
	sort.Strings(remotes)
	return Choose("remote", remotes, nil, false)
}

// ReadLine reads some input
var ReadLine = func() string {
	buf := bufio.NewReader(os.Stdin)
	line, err := buf.ReadString('\n')
	if err != nil {
		log.Fatalf("Failed to read line: %v", err)
	}
	return strings.TrimSpace(line)
}

// Choose one of the defaults or type a new string if newOk is set
func Choose(what string, defaults, help []string, newOk bool) string {
	valueDescription := "an existing"
	if newOk {
		valueDescription = "your own"
	}
	fmt.Printf("Choose a number from below, or type in %s value\n", valueDescription)
	for i, text := range defaults {
		var lines []string
		if help != nil {
			parts := strings.Split(help[i], "\n")
			lines = append(lines, parts...)
		}
		lines = append(lines, fmt.Sprintf("%q", text))
		pos := i + 1
		if len(lines) == 1 {
			fmt.Printf("%2d > %s\n", pos, text)
		} else {
			mid := (len(lines) - 1) / 2
			for i, line := range lines {
				var sep rune
				switch i {
				case 0:
					sep = '/'
				case len(lines) - 1:
					sep = '\\'
				default:
					sep = '|'
				}
				number := "  "
				if i == mid {
					number = fmt.Sprintf("%2d", pos)
				}
				fmt.Printf("%s %c %s\n", number, sep, line)
			}
		}
	}
	for {
		fmt.Printf("%s> ", what)
		result := ReadLine()
		i, err := strconv.Atoi(result)
		if err != nil {
			if newOk {
				return result
			}
			for _, v := range defaults {
				if result == v {
					return result
				}
			}
			continue
		}
		if i >= 1 && i <= len(defaults) {
			return defaults[i-1]
		}
	}
}

// --- Save Config Data ---------------------------------------------------------------------------

// SaveConfig calling function which saves configuration file.
// if saveConfig returns error trying again after sleep.
func SaveConfig() {
	var err error
	for i := 0; i < fs.Config.LowLevelRetries+1; i++ {
		if err = saveConfig(); err == nil {
			return
		}
		waitingTimeMs := mathrand.Intn(1000)
		time.Sleep(time.Duration(waitingTimeMs) * time.Millisecond)
	}
	log.Fatalf("Failed to save config after %d tries: %v", fs.Config.LowLevelRetries, err)

	return
}

// saveConfig saves configuration file.
// if configKey has been set, the file will be encrypted.
func saveConfig() error {
	dir, name := filepath.Split(ConfigPath)
	err := os.MkdirAll(dir, os.ModePerm)
	if err != nil {
		return errors.Wrap(err, "failed to create config directory")
	}
	f, err := ioutil.TempFile(dir, name)
	if err != nil {
		return errors.Errorf("Failed to create temp file for new config: %v", err)
	}
	defer func() {
		if err := os.Remove(f.Name()); err != nil && !os.IsNotExist(err) {
			log.Printf("Failed to remove temp config file: %v", err)
		}
	}()

	var buf bytes.Buffer
	err = goconfig.SaveConfigData(getConfigData(), &buf)
	if err != nil {
		return errors.Errorf("Failed to save config file: %v", err)
	}

	if len(configKey) == 0 {
		if _, err := buf.WriteTo(f); err != nil {
			return errors.Errorf("Failed to write temp config file: %v", err)
		}
	} else {
		_, _ = fmt.Fprintln(f, "# Encrypted rclone configuration File")
		_, _ = fmt.Fprintln(f, "")
		_, _ = fmt.Fprintln(f, "RCLONE_ENCRYPT_V0:")

		// Generate new nonce and write it to the start of the ciphertext
		var nonce [24]byte
		n, _ := rand.Read(nonce[:])
		if n != 24 {
			return errors.Errorf("nonce short read: %d", n)
		}
		enc := base64.NewEncoder(base64.StdEncoding, f)
		_, err = enc.Write(nonce[:])
		if err != nil {
			return errors.Errorf("Failed to write temp config file: %v", err)
		}

		var key [32]byte
		copy(key[:], configKey[:32])

		b := secretbox.Seal(nil, buf.Bytes(), &nonce, &key)
		_, err = enc.Write(b)
		if err != nil {
			return errors.Errorf("Failed to write temp config file: %v", err)
		}
		_ = enc.Close()
	}

	err = f.Close()
	if err != nil {
		return errors.Errorf("Failed to close config file: %v", err)
	}

	var fileMode os.FileMode = 0600
	info, err := os.Stat(ConfigPath)
	if err != nil {
		log.Printf("Using default permissions for config file: %v", fileMode)
	} else if info.Mode() != fileMode {
		log.Printf("Keeping previous permissions for config file: %v", info.Mode())
		fileMode = info.Mode()
	}

	attemptCopyGroup(ConfigPath, f.Name())

	err = os.Chmod(f.Name(), fileMode)
	if err != nil {
		log.Printf("Failed to set permissions on config file: %v", err)
	}

	if err = os.Rename(ConfigPath, ConfigPath+".old"); err != nil && !os.IsNotExist(err) {
		return errors.Errorf("Failed to move previous config to backup location: %v", err)
	}
	if err = os.Rename(f.Name(), ConfigPath); err != nil {
		return errors.Errorf("Failed to move newly written config from %s to final location: %v", f.Name(), err)
	}
	if err := os.Remove(ConfigPath + ".old"); err != nil && !os.IsNotExist(err) {
		log.Printf("Failed to remove backup config file: %v", err)
	}
	return nil
}

// SetValueAndSave sets the key to the value and saves just that
// value in the config file.  It loads the old config file in from
// disk first and overwrites the given value only.
func SetValueAndSave(name, key, value string) (err error) {
	// Set the value in config in case we fail to reload it
	getConfigData().SetValue(name, key, value)
	// Reload the config file
	reloadedConfigFile, err := loadConfigFile()
	if err == errorConfigFileNotFound {
		// Config file not written yet so ignore reload
		return nil
	} else if err != nil {
		return err
	}
	_, err = reloadedConfigFile.GetSection(name)
	if err != nil {
		// Section doesn't exist yet so ignore reload
		return err
	}
	// Update the config file with the reloaded version
	configFile = reloadedConfigFile
	// Set the value in the reloaded version
	reloadedConfigFile.SetValue(name, key, value)
	// Save it again
	SaveConfig()
	return nil
}

// --- Config Path --------------------------------------------------------------------------------
// Return the path to the configuration file
func makeConfigPath() string {

	// Use rclone.conf from rclone executable directory if already existing
	exe, err := os.Executable()
	if err == nil {
		exedir := filepath.Dir(exe)
		cfgpath := filepath.Join(exedir, configFileName)
		_, err := os.Stat(cfgpath)
		if err == nil {
			return cfgpath
		}
	}

	// Find user's home directory
	homeDir, err := homedir.Dir()

	// Find user's configuration directory.
	// Prefer XDG config path, with fallback to $HOME/.config.
	// See XDG Base Directory specification
	// https://specifications.freedesktop.org/basedir-spec/latest/),
	xdgdir := os.Getenv("XDG_CONFIG_HOME")
	var cfgdir string
	if xdgdir != "" {
		// User's configuration directory for rclone is $XDG_CONFIG_HOME/rclone
		cfgdir = filepath.Join(xdgdir, "rclone")
	} else if homeDir != "" {
		// User's configuration directory for rclone is $HOME/.config/rclone
		cfgdir = filepath.Join(homeDir, ".config", "rclone")
	}

	// Use rclone.conf from user's configuration directory if already existing
	var cfgpath string
	if cfgdir != "" {
		cfgpath = filepath.Join(cfgdir, configFileName)
		_, err := os.Stat(cfgpath)
		if err == nil {
			return cfgpath
		}
	}

	// Use .rclone.conf from user's home directory if already existing
	var homeconf string
	if homeDir != "" {
		homeconf = filepath.Join(homeDir, hiddenConfigFileName)
		_, err := os.Stat(homeconf)
		if err == nil {
			return homeconf
		}
	}

	// Check to see if user supplied a --config variable or environment
	// variable.  We can't use pflag for this because it isn't initialised
	// yet so we search the command line manually.
	_, configSupplied := os.LookupEnv("RCLONE_CONFIG")
	if !configSupplied {
		for _, item := range os.Args {
			if item == "--config" || strings.HasPrefix(item, "--config=") {
				configSupplied = true
				break
			}
		}
	}

	// If user's configuration directory was found, then try to create it
	// and assume rclone.conf can be written there. If user supplied config
	// then skip creating the directory since it will not be used.
	if cfgpath != "" {
		// cfgpath != "" implies cfgdir != ""
		if configSupplied {
			return cfgpath
		}
		err := os.MkdirAll(cfgdir, os.ModePerm)
		if err == nil {
			return cfgpath
		}
	}

	// Assume .rclone.conf can be written to user's home directory.
	if homeconf != "" {
		return homeconf
	}

	// Default to ./.rclone.conf (current working directory) if everything else fails.
	if !configSupplied {
		log.Printf("Couldn't find home directory or read HOME or XDG_CONFIG_HOME environment variables.")
		log.Printf("Defaulting to storing config in current directory.")
		log.Printf("Use --config flag to workaround.")
		log.Printf("Error was: %v", err)
	}
	return hiddenConfigFileName
}

// --- Password Related ------------------------------------------------

// checkPassword normalises and validates the password
func checkPassword(password string) (string, error) {
	if !utf8.ValidString(password) {
		return "", errors.New("password contains invalid utf8 characters")
	}
	// Check for leading/trailing whitespace
	trimmedPassword := strings.TrimSpace(password)
	// Warn user if password has leading+trailing whitespace
	if len(password) != len(trimmedPassword) {
		_, _ = fmt.Fprintln(os.Stderr, "Your password contains leading/trailing whitespace - in previous versions of rclone this was stripped")
	}
	// Normalize to reduce weird variations.
	password = norm.NFKC.String(password)
	if len(password) == 0 || len(trimmedPassword) == 0 {
		return "", errors.New("no characters in password")
	}
	return password, nil
}

// GetPassword asks the user for a password with the prompt given.
func GetPassword(prompt string) string {
	_, _ = fmt.Fprintln(PasswordPromptOutput, prompt)
	for {
		_, _ = fmt.Fprint(PasswordPromptOutput, "password:")
		password := ReadPassword()
		password, err := checkPassword(password)
		if err == nil {
			return password
		}
		_, _ = fmt.Fprintf(os.Stderr, "Bad password: %v\n", err)
	}
}

// ChangePassword will query the user twice for the named password. If
// the same password is entered it is returned.
func ChangePassword(name string) string {
	for {
		a := GetPassword(fmt.Sprintf("Enter %s password:", name))
		b := GetPassword(fmt.Sprintf("Confirm %s password:", name))
		if a == b {
			return a
		}
		fmt.Println("Passwords do not match!")
	}
}

// getConfigPassword will query the user for a password the
// first time it is required.
func getConfigPassword(q string) {
	if len(configKey) != 0 {
		return
	}
	for {
		password := GetPassword(q)
		err := setConfigPassword(password)
		if err == nil {
			return
		}
		_, _ = fmt.Fprintln(os.Stderr, "Error:", err)
	}
}

// setConfigPassword will set the configKey to the hash of
// the password. If the length of the password is
// zero after trimming+normalization, an error is returned.
func setConfigPassword(password string) error {
	password, err := checkPassword(password)
	if err != nil {
		return err
	}
	// Create SHA256 has of the password
	sha := sha256.New()
	_, err = sha.Write([]byte("[" + password + "][rclone-config]"))
	if err != nil {
		return err
	}
	configKey = sha.Sum(nil)
	if PassConfigKeyForDaemonization {
		tempFile, err := ioutil.TempFile("", "rclone")
		if err != nil {
			log.Fatalf("cannot create temp file to store configKey: %v", err)
		}
		_, err = tempFile.WriteString(obscure.MustObscure(string(configKey)))
		if err != nil {
			errRemove := os.Remove(tempFile.Name())
			if errRemove != nil {
				log.Fatalf("error writing configKey to temp file and also error deleting it: %v", err)
			}
			log.Fatalf("error writing configKey to temp file: %v", err)
		}
		err = tempFile.Close()
		if err != nil {
			errRemove := os.Remove(tempFile.Name())
			if errRemove != nil {
				log.Fatalf("error closing temp file with configKey and also error deleting it: %v", err)
			}
			log.Fatalf("error closing temp file with configKey: %v", err)
		}
		log.Printf("saving configKey to temp file")
		err = os.Setenv("_RCLONE_CONFIG_KEY_FILE", tempFile.Name())
		if err != nil {
			errRemove := os.Remove(tempFile.Name())
			if errRemove != nil {
				log.Fatalf("unable to set environment variable _RCLONE_CONFIG_KEY_FILE and unable to delete the temp file: %v", err)
			}
			log.Fatalf("unable to set environment variable _RCLONE_CONFIG_KEY_FILE: %v", err)
		}
	}
	return nil
}

// changeConfigPassword will query the user twice
// for a password. If the same password is entered
// twice the key is updated.
func changeConfigPassword() {
	err := setConfigPassword(ChangePassword("NEW configuration"))
	if err != nil {
		fmt.Printf("Failed to set config password: %v\n", err)
		return
	}
}
