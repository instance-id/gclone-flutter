import 'package:flutter/material.dart';

const APP_VERSION = 'v0.0.1';
const APP_NAME = 'gclone';
final AppIcon =
    Image.asset('res/images/launcher_icon.png', height: 64.0, width: 64.0);
const APP_DESCRIPTION = 'A Rclone multiplatform GUI '
    '\n\nDeveloped by instance.id.';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=io.github.x_wei.flutter_catalog';
const GITHUB_URL = 'https://github.com/instance-id/gclone_flutter';
const AUTHOR_SITE = 'http://instance.id';

class CardDetails {
  CardDetails(this.key, this.icon, this.title);

  final String key;
  final IconData icon;
  final String title;

  bool operator ==(o) => o is CardDetails && o.key == key;
  int get hashCode => key.hashCode;
}
