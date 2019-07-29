import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gclone/helpers/icons_helper.dart';

class ProviderData with ChangeNotifier {
  String name;
  String provider;
  String type;
  List<String> fields;
  String level;
  double indicatorValue;
  int price;
  String content;
  IconData icon;
  String key;
  String note;

  ProviderData({
    this.name,
    this.provider,
    this.type,
    this.fields,
    this.level,
    this.indicatorValue,
    this.price,
    this.content,
    this.icon,
    this.key,
    this.note,
  });
}

List<ProviderData> getProviderList() {
  return [
    // --------------------------------------------------------------------------------------------------------------------------------------- Amazon Drive ---
    ProviderData(
        name: "Amazon Drive",
        provider: "Amazon Drive",
        type: "amazon cloud drive",
        fields: [
          "type",
          "provider",
          "client_id",
          "client_secret",
          "auth_url",
          "token_url",
          "token"
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Amazon Drive, formerly known as Amazon Cloud Drive, is a cloud storage service run by Amazon for consumers. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Amazon S3 ---
    ProviderData(
        name: "Amazon S3",
        provider: "AWS",
        type: "s3",
        fields: [
          "type",
          "provider",
          "env_auth",
          "access_key_id",
          "secret_access_key",
          "region",
          "endpoint",
          "location_constraint",
          "acl",
          "server_side_encryption",
          "storage_class"
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Alibaba OSS ---
    ProviderData(
        name: "Alibaba OSS",
        provider: "Alibaba",
        type: "s3",
        fields: [
          "type",
          "provider",
          "env_auth",
          "access_key_id",
          "secret_access_key",
          "endpoint",
          "acl",
          "storage_class"
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Backblaze ---
    ProviderData(
        name: "Backblaze B2",
        provider: "Backblaze B2",
        type: "b2",
        fields: ["type", "provider", "account", "key", "endpoint"],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Box ---
    ProviderData(
        name: "Box",
        provider: "Box",
        type: "box",
        fields: [
          "type",
          "provider",
          "client_id",
          "client_secret",
          "token",
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Ceph ---
    ProviderData(
        name: "Ceph",
        provider: "Ceph",
        type: "s3",
        fields: [
          "type",
          "provider",
          "env_auth",
          "access_key_id",
          "secret_access_key",
          "region",
          "endpoint",
          "location_constraint",
          "acl",
          "server_side_encryption",
          "storage_class"
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- DigitalOcean ---
    ProviderData(
        name: "DigitalOcean Spaces",
        provider: "DigitalOcean",
        type: "s3",
        fields: [
          "type",
          "provider",
          "env_auth",
          "access_key_id",
          "secret_access_key",
          "region",
          "endpoint",
          "location_constraint," "acl",
          "server_side_encryption",
          "storage_class"
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Dreamhost ---
    ProviderData(
        name: "Dreamhost",
        provider: "Dreamhost",
        type: "s3",
        fields: [
          "type",
          "provider",
          "env_auth",
          "access_key_id",
          "secret_access_key",
          "region",
          "endpoint",
          "location_constraint",
          "acl",
          "server_side_encryption",
          "storage_class"
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Dropbox ---
    ProviderData(
        name: "Dropbox",
        provider: "Dropbox",
        type: "dropbox",
        fields: ["type", "provider", "app_key", "app_secret", "token"],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- FTP ---
    ProviderData(
        name: "FTP Connection",
        provider: "ftp",
        type: "ftp",
        fields: ["type", "provider", "host", "pass"],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Google Cloud  ---
    ProviderData(
        name: "Google Cloud Storage",
        provider: "google cloud storage",
        type: "google cloud storage",
        fields: [
          "type",
          "provider",
          "client_id",
          "client_secret",
          "token",
          "project_number",
          "object_acl",
          "bucket_acl"
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Google Drive ---
    ProviderData(
        name: "Google Drive",
        provider: "Google Drive",
        type: "drive",
        fields: [
          "type",
          "provider",
          "client_id",
          "client_secret",
          "scope",
          "root_folder_id",
          "service_account_file",
          "token"
        ],
        icon: getFontAwesomeIcon(name: "googleDrive"),
        level: "Last run: Successful",
        indicatorValue: 1,
        price: 20,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Hubic ---
    ProviderData(
        name: "Hubic",
        provider: "Hubic",
        type: "hubic",
        fields: ["type", "provider", "client_id", "client_secret", "token"],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- IBMCOS ---
    ProviderData(
        name: "IBM COS",
        provider: "IBMCOS",
        type: "IBMCOS",
        fields: [
          "type",
          "provider",
          "access_key_id",
          "secret_access_key",
          "endpoint",
          "location_constraint",
          "acl",
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Local Storage ---
    ProviderData(
        name: "Local Storage",
        provider: "Local Storage",
        type: "local",
        fields: ["type", "provider", "nounc"],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Microsoft OneDrive ---
    ProviderData(
        name: "Microsoft OneDrive",
        provider: "OneDrive",
        type: "onedrive",
        fields: ["type", "provider", "token", "drive_id", "drive_type"],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Minio ---
    ProviderData(
        name: "Minio",
        provider: "Minio",
        type: "s3",
        fields: [
          "type",
          "provider",
          "env_auth",
          "access_key_id",
          "secret_access_key",
          "region",
          "endpoint",
          "location_constraint",
          "server_side_encryption",
        ],
        icon: getFontAwesomeIcon(name: "google"),
        level: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Openstack ---
    ProviderData(
        name: "Openstack Swift",
        provider: "Openstack Swift",
        type: "swift",
        fields: [
          "type",
          "provider",
          "env_auth",
          "user",
          "key",
          "auth",
          "user_id",
          "domain",
          "tenant",
          "tenant_id",
          "tenant_domain",
          "region",
          "storage_url",
          "auth_token",
          "auth_version",
          "endpoint_type",
        ],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Rackspace ---
    ProviderData(
        name: "Rackspace Cloud Files",
        provider: "Rackspace",
        type: "swift",
        fields: [
          "type",
          "provider",
          "env_auth",
          "user",
          "key",
          "auth",
          "user_id",
          "domain",
          "tenant",
          "tenant_id",
          "tenant_domain",
          "region",
          "storage_url",
          "auth_token",
          "auth_version",
          "endpoint_type",
        ],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Memset ---
    ProviderData(
        name: "Memset Memstore",
        provider: "Memset Memstore",
        type: "swift",
        fields: [
          "type",
          "provider",
          "env_auth",
          "user",
          "key",
          "auth",
          "user_id",
          "domain",
          "tenant",
          "tenant_id",
          "tenant_domain",
          "region",
          "storage_url",
          "auth_token",
          "auth_version",
          "endpoint_type",
        ],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- OVH ---
    ProviderData(
        name: "OVH",
        provider: "OVH",
        type: "swift",
        fields: [
          "type",
          "provider",
          "env_auth",
          "user",
          "key",
          "auth",
          "user_id",
          "domain",
          "tenant",
          "tenant_id",
          "tenant_domain",
          "region",
          "storage_url",
          "auth_token",
          "auth_version",
          "endpoint_type",
        ],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- SSH/SFTP ---
    ProviderData(
        name: "SSH/SFTP Connection",
        provider: "sftp",
        type: "sftp",
        fields: [
          "type",
          "provider",
          "host",
          "user",
          "port",
          "pass",
          "key_file"
        ],
        icon: getFontAwesomeIcon(name: "solidFolder"),
        level: "Last run: Error",
        indicatorValue: 0,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Wasabi ---
    ProviderData(
        name: "Wasabi",
        provider: "Wasabi",
        type: "s3",
        fields: [
          "type",
          "provider",
          "env_auth",
          "access_key_id",
          "secret_access_key",
          "region",
          "endpoint",
          "location_constraint",
          "acl",
          "server_side_encryption",
          "storage_class"
        ],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- Yandex ---
    ProviderData(
        name: "Yandex",
        provider: "yandex",
        type: "yandex",
        fields: ["type", "provider", "client_id", "client_secret", "token"],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
    // --------------------------------------------------------------------------------------------------------------------------------------- HTTP ---
    ProviderData(
        name: "HTTP Connection",
        provider: "http",
        type: "http",
        fields: ["type", "provider", "url"],
        icon: getFontAwesomeIcon(name: "usb"),
        level: "Last run: Successful",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface "
            "elements cannot be clicked due to the modal barrier that is constructed."),
  ];
}
