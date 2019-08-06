package main

import (
	"github.com/chunhunghan/file_picker"
	"github.com/go-flutter-desktop/go-flutter"

	"github.com/instance-id/gclone-plugins/version"
	"github.com/instance-id/gclone_flutter/backend/plugins/data"
	"github.com/instance-id/gclone_flutter/backend/plugins/dragable"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(1050, 650),
	flutter.WindowMode(flutter.WindowModeBorderless),
	flutter.AddPlugin(version.VersionPlugin{}),
	flutter.AddPlugin(&data.DataPlugin{}),
	flutter.AddPlugin(&file_picker.FilePickerPlugin{}),
	flutter.AddPlugin(&dragable.AppBarDragable{}),
	flutter.PopBehavior(flutter.PopBehaviorClose),
}
