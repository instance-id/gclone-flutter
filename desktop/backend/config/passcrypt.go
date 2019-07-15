package config

//
//// checkPassword normalises and validates the password
//func checkPassword(password string) (string, error) {
//	if !utf8.ValidString(password) {
//		return "", errors.New("password contains invalid utf8 characters")
//	}
//	// Check for leading/trailing whitespace
//	trimmedPassword := strings.TrimSpace(password)
//	// Warn user if password has leading+trailing whitespace
//	if len(password) != len(trimmedPassword) {
//		_, _ = fmt.Fprintln(os.Stderr, "Your password contains leading/trailing whitespace - in previous versions of rclone this was stripped")
//	}
//	// Normalize to reduce weird variations.
//	password = norm.NFKC.String(password)
//	if len(password) == 0 || len(trimmedPassword) == 0 {
//		return "", errors.New("no characters in password")
//	}
//	return password, nil
//}
//
//// GetPassword asks the user for a password with the prompt given.
//func GetPassword(prompt string) string {
//	_, _ = fmt.Fprintln(PasswordPromptOutput, prompt)
//	for {
//		_, _ = fmt.Fprint(PasswordPromptOutput, "password:")
//		password := ReadPassword()
//		password, err := checkPassword(password)
//		if err == nil {
//			return password
//		}
//		_, _ = fmt.Fprintf(os.Stderr, "Bad password: %v\n", err)
//	}
//}
//
//// ChangePassword will query the user twice for the named password. If
//// the same password is entered it is returned.
//func ChangePassword(name string) string {
//	for {
//		a := GetPassword(fmt.Sprintf("Enter %s password:", name))
//		b := GetPassword(fmt.Sprintf("Confirm %s password:", name))
//		if a == b {
//			return a
//		}
//		fmt.Println("Passwords do not match!")
//	}
//}
//
//// getConfigPassword will query the user for a password the
//// first time it is required.
//func getConfigPassword(q string) {
//	if len(configKey) != 0 {
//		return
//	}
//	for {
//		password := GetPassword(q)
//		err := setConfigPassword(password)
//		if err == nil {
//			return
//		}
//		_, _ = fmt.Fprintln(os.Stderr, "Error:", err)
//	}
//}
//
//// setConfigPassword will set the configKey to the hash of
//// the password. If the length of the password is
//// zero after trimming+normalization, an error is returned.
//func setConfigPassword(password string) error {
//	password, err := checkPassword(password)
//	if err != nil {
//		return err
//	}
//	// Create SHA256 has of the password
//	sha := sha256.New()
//	_, err = sha.Write([]byte("[" + password + "][rclone-config]"))
//	if err != nil {
//		return err
//	}
//	configKey = sha.Sum(nil)
//	if PassConfigKeyForDaemonization {
//		tempFile, err := ioutil.TempFile("", "rclone")
//		if err != nil {
//			log.Fatalf("cannot create temp file to store configKey: %v", err)
//		}
//		_, err = tempFile.WriteString(obscure.MustObscure(string(configKey)))
//		if err != nil {
//			errRemove := os.Remove(tempFile.Name())
//			if errRemove != nil {
//				log.Fatalf("error writing configKey to temp file and also error deleting it: %v", err)
//			}
//			log.Fatalf("error writing configKey to temp file: %v", err)
//		}
//		err = tempFile.Close()
//		if err != nil {
//			errRemove := os.Remove(tempFile.Name())
//			if errRemove != nil {
//				log.Fatalf("error closing temp file with configKey and also error deleting it: %v", err)
//			}
//			log.Fatalf("error closing temp file with configKey: %v", err)
//		}
//		log.Printf("saving configKey to temp file")
//		err = os.Setenv("_RCLONE_CONFIG_KEY_FILE", tempFile.Name())
//		if err != nil {
//			errRemove := os.Remove(tempFile.Name())
//			if errRemove != nil {
//				log.Fatalf("unable to set environment variable _RCLONE_CONFIG_KEY_FILE and unable to delete the temp file: %v", err)
//			}
//			log.Fatalf("unable to set environment variable _RCLONE_CONFIG_KEY_FILE: %v", err)
//		}
//	}
//	return nil
//}
//
//// changeConfigPassword will query the user twice
//// for a password. If the same password is entered
//// twice the key is updated.
//func changeConfigPassword() {
//	err := setConfigPassword(ChangePassword("NEW configuration"))
//	if err != nil {
//		fmt.Printf("Failed to set config password: %v\n", err)
//		return
//	}
//}
