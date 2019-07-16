package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/instance-id/gclone-plugins/version"
	"github.com/instance-id/gclone_flutter/backend/plugins/data"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(1200, 650),
	flutter.AddPlugin(version.VersionPlugin{}),
	flutter.AddPlugin(&data.DataPlugin{}),
}
