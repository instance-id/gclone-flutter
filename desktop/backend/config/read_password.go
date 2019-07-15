package config

import (
	"fmt"
	"log"
	"os"

	"golang.org/x/crypto/ssh/terminal"
)

// ReadPassword reads a password without echoing it to the terminal.
func ReadPassword() string {
	stdin := int(os.Stdin.Fd())
	if !terminal.IsTerminal(stdin) {
		return ReadLine()
	}
	line, err := terminal.ReadPassword(stdin)
	_, _ = fmt.Fprintln(os.Stderr)
	if err != nil {
		log.Fatalf("Failed to read password: %v", err)
	}
	return string(line)
}
