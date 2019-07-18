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
	return RMData, nil
}

func (d *DataPlugin) getRemotesFunc(arguments interface{}) (reply interface{}, err error) {

	_, sections := GetRemotes()
	var sectionList = make([]interface{}, len(sections))

	for k, v := range sections {
		//RMData[v] = &RemoteDataConfig{Name: v}
		//secData, _ := cfg.GetSection(v)
		//
		//switch secData["type"] {
		//case "drive":
		//	//RMData[v] = &RemoteDataConfig{Name: v, Type: secData["type"], Scope: secData["scope"], Token: secData["token"], ClientId: secData["client_id"], ClientSecret: secData["client_secret"]}
		//	RMData[v] = SetupDrive(v, secData)
		//}

		sectionList[k] = v
	}

	return sectionList, nil
}

func SetupDrive(name string, secData map[string]string) *RemoteDataConfig {
	return &RemoteDataConfig{
		Name:         name,
		Type:         secData["type"],
		Scope:        secData["scope"],
		Token:        secData["token"],
		ClientId:     secData["client_id"],
		ClientSecret: secData["client_secret"]}
}
