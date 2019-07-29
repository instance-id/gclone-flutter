package data

import (
	"github.com/Unknwon/goconfig"
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	. "github.com/instance-id/gclone_flutter/backend/config"
	confg "gopkg.in/gcfg.v1"
)

const (
	channelName = "instance.id/go/data"
	getData     = "getData"
	getRemotes  = "getRemotes"
)

type DataPlugin struct{}

var cfg *goconfig.ConfigFile
var _ flutter.Plugin = &DataPlugin{}

var Data = make(map[interface{}]interface{})

func (d *DataPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	channel.HandleFunc(getData, d.getDataFunc)
	channel.HandleFunc(getRemotes, d.getRemotesFunc)

	config := struct {
		Section struct {
			Name string
		}
	}{}
	_ = confg.ReadFileInto(&config, ConfigPath)
	LoadConfig()

	return nil
}

func (d *DataPlugin) getDataFunc(arguments interface{}) (reply interface{}, err error) {
	return Data, nil
}

func (d *DataPlugin) getRemotesFunc(arguments interface{}) (reply interface{}, err error) {

	config := struct {
		Section struct {
			Name string
		}
	}{}
	_ = confg.ReadFileInto(&config, ConfigPath)
	LoadConfig()
	cfg, sections := GetRemotes()
	var sectionList = make([]interface{}, len(sections))

	for k, v := range sections {
		//Data[v] = &RemoteDataConfig{Name: v}
		secData, _ := cfg.GetSection(v)

		switch secData["type"] {
		case "drive":
			Data[v] = map[interface{}]interface{}{"name": v, "type": secData["type"], "scope": secData["scope"], "token": secData["token"], "client_id": secData["client_id"], "client_secret": secData["client_secret"]}
		case "google cloud storage":
			Data[v] = map[interface{}]interface{}{"name": v, "type": secData["type"], "project_number": secData["project_number"], "object_acl": secData["object_acl"], "bucket_acl": secData["bucket_acl"], "token": secData["token"], "client_id": secData["client_id"], "client_secret": secData["client_secret"]}
		case "sftp":
			Data[v] = map[interface{}]interface{}{"name": v, "type": secData["type"], "host": secData["host"], "user": secData["user"], "port": secData["port"], "pass": secData["pass"], "key_file": secData["key_file"]}

		}
		//RMData = Data
		sectionList[k] = v
	}
	return sectionList, nil
}

//func SetupDrive(name string, secData map[string]string) *RemoteDataConfig {
//	return &RemoteDataConfig{
//		Name:         name,
//		Type:         secData["type"],
//		Scope:        secData["scope"],
//		Token:        secData["token"],
//		ClientId:     secData["client_id"],
//		ClientSecret: secData["client_secret"]}
//}
