import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gclone/helpers/icons_helper.dart';

class ProviderData with ChangeNotifier {
  List<ProviderData> providerList;
  String name;
  String provider;
  String type;
  List<String> fields;
  String status;
  double indicatorValue;
  int price;
  String content;
  IconData icon;
  String key;
  String note;
  int providerID;

  ProviderData({
    this.name,
    this.provider,
    this.type,
    this.fields,
    this.status,
    this.indicatorValue,
    this.price,
    this.content,
    this.icon,
    this.key,
    this.note,
    this.providerID,
  });

  bool operator ==(o) => o is ProviderData && o.key == key;
  int get hashCode => key.hashCode;

  getList() {
    return providerList = getProviderList();
  }

  List<ProviderData> getProviderList() {
    return [
      // --------------------------------------------------------------------------------------------------------------------------------------- Amazon Drive ---
//      ProviderData(
//          name: "Amazon Drive",
//          providerID: 3,
//          provider: "amazon cloud drive",
//          type: "amazon cloud drive",
//          fields: [
//            "type",
//            "provider",
//            "client_id",
//            "client_secret",
//            "auth_url",
//            "token_url",
//            "token"
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Amazon Drive, formerly known as Amazon Cloud Drive, is a cloud storage service run by Amazon for consumers. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed.",
//          note: "Amazon drive is something something, sup?",
//          ),
      // --------------------------------------------------------------------------------------------------------------------------------------- Amazon S3 ---
//      ProviderData(
//          name: "Amazon S3",
//          providerID: 4,
//          provider: "AWS",
//          type: "s3",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "access_key_id",
//            "secret_access_key",
//            "region",
//            "endpoint",
//            "location_constraint",
//            "acl",
//            "server_side_encryption",
//            "storage_class"
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed.",
//          note: "Amazon S3 Compliant Storage Provider (AWS, Alibaba, Ceph, Digital Ocean, Dreamhost, IBM COS, Minio, etc)",
//              ),
      // --------------------------------------------------------------------------------------------------------------------------------------- Alibaba OSS ---
//      ProviderData(
//          name: "Alibaba OSS",
//          providerID: 4,
//          provider: "Alibaba",
//          type: "s3",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "access_key_id",
//            "secret_access_key",
//            "endpoint",
//            "acl",
//            "storage_class"
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed.",
//          note: "S3 Compliant Storage Provider",
//              ),
      // --------------------------------------------------------------------------------------------------------------------------------------- Backblaze ---
//      ProviderData(
//          name: "Backblaze B2",
//          providerID: 5,
//          provider: "Backblaze B2",
//          type: "b2",
//          fields: ["type", "provider", "account", "key", "endpoint"],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Box ---
//      ProviderData(
//          name: "Box",
//          providerID: 6,
//          provider: "Box",
//          type: "box",
//          fields: [
//            "type",
//            "provider",
//            "client_id",
//            "client_secret",
//            "token",
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Ceph ---
//      ProviderData(
//          name: "Ceph",
//          providerID: 4,
//          provider: "Ceph",
//          type: "s3",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "access_key_id",
//            "secret_access_key",
//            "region",
//            "endpoint",
//            "location_constraint",
//            "acl",
//            "server_side_encryption",
//            "storage_class"
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed.",
//          note: "S3 Compliant Storage Provider",
//              ),
      // --------------------------------------------------------------------------------------------------------------------------------------- DigitalOcean ---
      ProviderData(
        name: "DigitalOcean Spaces",
        providerID: 4,
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
        status: "Backup in progress",
        indicatorValue: 0.75,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. "
            "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
            "You should see a circular progress indicator display in the middle of the page and the user interface elements "
            "cannot be clicked due to the modal barrier that is constructed.",
        note: "S3 Compliant Storage Provider",
      ),
      // --------------------------------------------------------------------------------------------------------------------------------------- Dreamhost ---
//      ProviderData(
//          name: "Dreamhost",
//          providerID: 7,
//          provider: "Dreamhost",
//          type: "s3",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "access_key_id",
//            "secret_access_key",
//            "region",
//            "endpoint",
//            "location_constraint",
//            "acl",
//            "server_side_encryption",
//            "storage_class"
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed.",
//          note: "S3 Compliant Storage Provider",
//              ),
      // --------------------------------------------------------------------------------------------------------------------------------------- Dropbox ---
//      ProviderData(
//          name: "Dropbox",
//          providerID: 8,
//          provider: "Dropbox",
//          type: "dropbox",
//          fields: ["type", "provider", "app_key", "app_secret", "token"],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- FTP ---
//      ProviderData(
//          name: "FTP Connection",
//          providerID: 10,
//          provider: "ftp",
//          type: "ftp",
//          fields: ["type", "provider", "host", "pass"],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Google Cloud  ---
      ProviderData(
          name: "Google Cloud Storage",
          providerID: 11,
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
          status: "Backup in progress",
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
          providerID: 12,
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
          status: "Last run: Successful",
          indicatorValue: 1,
          price: 20,
          content:
              "Start by taking a couple of minutes to read the info in this section. "
              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
              "You should see a circular progress indicator display in the middle of the page and the user interface "
              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Hubic ---
//      ProviderData(
//          name: "Hubic",
//          providerID: 13,
//          provider: "Hubic",
//          type: "hubic",
//          fields: ["type", "provider", "client_id", "client_secret", "token"],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- IBMCOS ---
//      ProviderData(
//          name: "IBM COS",
//          providerID: 13,
//          provider: "IBMCOS",
//          type: "IBMCOS",
//          fields: [
//            "type",
//            "provider",
//            "access_key_id",
//            "secret_access_key",
//            "endpoint",
//            "location_constraint",
//            "acl",
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Local Storage ---
      ProviderData(
          name: "Local Storage",
          providerID: 15,
          provider: "Local Storage",
          type: "local",
          fields: ["type", "provider", "nounc"],
          icon: getFontAwesomeIcon(name: "usb"),
          status: "Last run: Successful",
          indicatorValue: 1.0,
          price: 50,
          content:
              "Start by taking a couple of minutes to read the info in this section. "
              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
              "You should see a circular progress indicator display in the middle of the page and the user interface "
              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Microsoft OneDrive ---
//      ProviderData(
//          name: "Microsoft OneDrive",
//          providerID: 17,
//          provider: "OneDrive",
//          type: "onedrive",
//          fields: ["type", "provider", "token", "drive_id", "drive_type"],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Minio ---
//      ProviderData(
//          name: "Minio",
//          providerID: 4,
//          provider: "Minio",
//          type: "s3",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "access_key_id",
//            "secret_access_key",
//            "region",
//            "endpoint",
//            "location_constraint",
//            "server_side_encryption",
//          ],
//          icon: getFontAwesomeIcon(name: "google"),
//          status: "Backup in progress",
//          indicatorValue: 0.75,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface elements "
//              "cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Openstack ---
//      ProviderData(
//          name: "Openstack Swift",
//          providerID: 19,
//          provider: "Openstack Swift",
//          type: "swift",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "user",
//            "key",
//            "auth",
//            "user_id",
//            "domain",
//            "tenant",
//            "tenant_id",
//            "tenant_domain",
//            "region",
//            "storage_url",
//            "auth_token",
//            "auth_version",
//            "endpoint_type",
//          ],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Rackspace ---
//      ProviderData(
//          name: "Rackspace Cloud Files",
//          providerID: 19,
//          provider: "Rackspace",
//          type: "swift",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "user",
//            "key",
//            "auth",
//            "user_id",
//            "domain",
//            "tenant",
//            "tenant_id",
//            "tenant_domain",
//            "region",
//            "storage_url",
//            "auth_token",
//            "auth_version",
//            "endpoint_type",
//          ],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Memset ---
//      ProviderData(
//          name: "Memset Memstore",
//          providerID: 19,
//          provider: "Memset Memstore",
//          type: "swift",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "user",
//            "key",
//            "auth",
//            "user_id",
//            "domain",
//            "tenant",
//            "tenant_id",
//            "tenant_domain",
//            "region",
//            "storage_url",
//            "auth_token",
//            "auth_version",
//            "endpoint_type",
//          ],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- OVH ---
//      ProviderData(
//          name: "OVH",
//          providerID: 19,
//          provider: "OVH",
//          type: "swift",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "user",
//            "key",
//            "auth",
//            "user_id",
//            "domain",
//            "tenant",
//            "tenant_id",
//            "tenant_domain",
//            "region",
//            "storage_url",
//            "auth_token",
//            "auth_version",
//            "endpoint_type",
//          ],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- SSH/SFTP ---
      ProviderData(
          name: "SSH/SFTP Connection",
          providerID: 21,
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
          status: "Last run: Error",
          indicatorValue: 0,
          price: 30,
          content:
              "Start by taking a couple of minutes to read the info in this section. "
              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
              "You should see a circular progress indicator display in the middle of the page and the user interface "
              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Wasabi ---
//      ProviderData(
//          name: "Wasabi",
//          providerID: 4,
//          provider: "Wasabi",
//          type: "s3",
//          fields: [
//            "type",
//            "provider",
//            "env_auth",
//            "access_key_id",
//            "secret_access_key",
//            "region",
//            "endpoint",
//            "location_constraint",
//            "acl",
//            "server_side_encryption",
//            "storage_class"
//          ],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- Yandex ---
//      ProviderData(
//          name: "Yandex",
//          providerID: 23,
//          provider: "yandex",
//          type: "yandex",
//          fields: ["type", "provider", "client_id", "client_secret", "token"],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
      // --------------------------------------------------------------------------------------------------------------------------------------- HTTP ---
//      ProviderData(
//          name: "HTTP Connection",
//          providerID: 24,
//          provider: "http",
//          type: "http",
//          fields: ["type", "provider", "url"],
//          icon: getFontAwesomeIcon(name: "usb"),
//          status: "Last run: Successful",
//          indicatorValue: 1.0,
//          price: 50,
//          content:
//              "Start by taking a couple of minutes to read the info in this section. "
//              "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  "
//              "You should see a circular progress indicator display in the middle of the page and the user interface "
//              "elements cannot be clicked due to the modal barrier that is constructed."),
    ];
  }
}
