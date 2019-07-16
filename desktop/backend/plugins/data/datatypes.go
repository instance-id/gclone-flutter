package data

var RMData = map[string]*RemoteDataConfig{}

type RemoteDataConfig struct {
	Name string `json:"name"`
	Type string `json:"type"`

	ClientId       string `json:"client_id"`
	ClientSecret   string `json:"client_secret"`
	Scope          string `json:"scope"`
	RootFolder     string `json:"root_folder_id"`
	ServiceAccount string `json:"service_account_file"`
	Token          string `json:"token"`

	Provider              string `config:"provider"`
	EnvAuth               string `config:"env_auth"`
	AccessKeyID           string `config:"access_key_id"`
	SecretAccessKey       string `config:"secret_access_key"`
	Region                string `config:"region"`
	Endpoint              string `config:"endpoint"`
	LocationConstraint    string `config:"location_constraint"`
	ACL                   string `config:"acl"`
	BucketACL             string `config:"bucket_acl"`
	ServerSideEncryption  string `config:"server_side_encryption"`
	SSEKMSKeyID           string `config:"sse_kms_key_id"`
	StorageClass          string `config:"storage_class"`
	UploadCutoff          string `config:"upload_cutoff"`
	ChunkSize             string `config:"chunk_size"`
	DisableChecksum       string `config:"disable_checksum"`
	SessionToken          string `config:"session_token"`
	UploadConcurrency     string `config:"upload_concurrency"`
	ForcePathStyle        string `config:"force_path_style"`
	V2Auth                string `config:"v2_auth"`
	UseAccelerateEndpoint string `config:"use_accelerate_endpoint"`

	Vendor string `json:"vendor"`
	Url    string `json:"url"`
	User   string `json:"user"`
	Pass   string `json:"pass"`

	Remote                  string `json:"remote"`
	FilenameEncryption      string `json:"filename_encryption"`
	Password                string `json:"password"`
	Password2               string `json:"password2"`
	DirectoryNameEncryption string `json:"directory_name_encryption"`

	Account    string `json:"account"`
	Key        string `json:"key"`
	HardDelete string `json:"hard_delete"`
}
