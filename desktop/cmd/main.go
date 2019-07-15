package main

import (
	"fmt"
	"image"
	_ "image/png"
	"io/ioutil"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"github.com/getlantern/systray"
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/instance-id/gclone_flutter/backend"
	"github.com/pkg/errors"
)

// vmArguments may be set by hover at compile-time
var vmArguments string

func main() {
	backend.Gclone()
	systray.Run(onReady, onExit)

}

func StartApp() {
	// DO NOT EDIT, add options in options.go
	mainOptions := []flutter.Option{
		flutter.OptionVMArguments(strings.Split(vmArguments, ";")),
		flutter.WindowIcon(iconProvider),
	}
	err := flutter.Run(append(options, mainOptions...)...)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func iconProvider() ([]image.Image, error) {
	execPath, err := os.Executable()
	if err != nil {
		return nil, errors.Wrap(err, "failed to resolve executable path")
	}
	execPath, err = filepath.EvalSymlinks(execPath)
	if err != nil {
		return nil, errors.Wrap(err, "failed to eval symlinks for executable path")
	}
	imgFile, err := os.Open(filepath.Join(filepath.Dir(execPath), "assets", "icon.png"))
	if err != nil {
		return nil, errors.Wrap(err, "failed to open assets/icon.png")
	}
	img, _, err := image.Decode(imgFile)
	if err != nil {
		return nil, errors.Wrap(err, "failed to decode image")
	}
	return []image.Image{img}, nil
}

func onReady() {
	execPath, err := os.Executable()
	if err != nil {
	}
	systray.SetIcon(getIcon(filepath.Join(filepath.Dir(execPath), "assets", "icon.png")))

	mMain := systray.AddMenuItem("Main Window", "Show Main Window")
	systray.AddSeparator()
	mRunNow := systray.AddMenuItem("Run Backup Now", "Run Backup Now")
	mSchedule := systray.AddMenuItem("Configure Schedule", "Configure Backup Schedule")

	mQuit := systray.AddMenuItem("Quit", "Quits this app")

	systray.SetTitle("gclone")
	systray.SetTooltip("gclone backup utility")

	go func() {
		for {
			select {
			case <-mMain.ClickedCh:
				go StartApp()
			case <-mRunNow.ClickedCh:
				return
			case <-mSchedule.ClickedCh:
				return
			case <-mQuit.ClickedCh:
				systray.Quit()
				return
			}
		}
	}()
}

func getTime(tz string) string {
	t := time.Now()
	utc, _ := time.LoadLocation(tz)

	hour, min, sec := t.In(utc).Clock()
	return ItoaTwoDigits(hour) + ":" + ItoaTwoDigits(min) + ":" + ItoaTwoDigits(sec)
}

func ItoaTwoDigits(i int) string {
	b := "0" + strconv.Itoa(i)
	return b[len(b)-2:]
}

func onExit() {

}

func getIcon(s string) []byte {
	b, err := ioutil.ReadFile(s)
	if err != nil {
		fmt.Print(err)
	}
	return b
}

func MainWindow() {

}
