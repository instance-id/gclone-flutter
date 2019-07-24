package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/instance-id/gclone-plugins/version"
	"github.com/instance-id/gclone_flutter/backend/plugins/data"
	"github.com/chunhunghan/file_picker"

)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(1200, 650),
	flutter.AddPlugin(version.VersionPlugin{}),
	flutter.AddPlugin(&data.DataPlugin{}),
	flutter.AddPlugin(&file_picker.FilePickerPlugin{}),
}
