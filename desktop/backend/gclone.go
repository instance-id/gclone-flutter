package backend

import (
	"github.com/Unknwon/goconfig"
	. "github.com/instance-id/gclone_flutter/backend/config"
	confg "gopkg.in/gcfg.v1"
)

var cfg *goconfig.ConfigFile

func Gclone() {

	config := struct {
		Section struct {
			Name string
		}
	}{}

	_ = confg.ReadFileInto(&config, ConfigPath)

	LoadConfig()
	// ShowRemotes()
	cfg, sections := GetRemotes()
	for _, v := range sections {
		RMData[v] = &RemoteDataConfig{Name: v}
		secData, _ := cfg.GetSection(v)

		switch secData["type"] {
		case "drive":
			//RMData[v] = &RemoteDataConfig{Name: v, Type: secData["type"], Scope: secData["scope"], Token: secData["token"], ClientId: secData["client_id"], ClientSecret: secData["client_secret"]}
			RMData[v] = SetupDrive(v, secData)
		}
		//clientid, _ := cfg.GetValue(RMData[sections[k]].Name, "client_id")
		//clientsecret, _ := cfg.GetValue(RMData[sections[k]].Name, "client_secret")
		//fmt.Printf("Client_Id: %s : %s \n", clientid, clientsecret)
	}
}

func SetupDrive(name string, secData map[string]string) *RemoteDataConfig {
	return &RemoteDataConfig{Name: name, Type: secData["type"], Scope: secData["scope"], Token: secData["token"], ClientId: secData["client_id"], ClientSecret: secData["client_secret"]}
	//data.Type = secData["type"]
	//data.Scope = secData["scope"]
	//data.Token = secData["token"]
	//data.ClientId = secData["client_id"]
	//data.ClientSecret = secData["client_secret"]
	//return data
}
