import 'package:flutter/material.dart';

class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;
  IconData icon;
  String key;

  Lesson(
      {this.title,
      this.level,
      this.indicatorValue,
      this.price,
      this.content,
      this.icon,
      this.key});
}
