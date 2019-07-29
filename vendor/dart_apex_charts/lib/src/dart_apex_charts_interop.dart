@JS()
library chart;

//TODO dev this version API

import "package:js/js.dart";
import 'dart:html';

@JS()
class ApexCharts {
  external dynamic render();

  external ApexCharts(Element context, Options options);
}

@JS()
@anonymous
class Options {
  external Chart get chart;

  external List get series;

  external List<String> get colors;

  external Xaxis get xaxis;

  external factory Options(
      {Chart chart, List series, List<String> colors, Xaxis xaxis});
}

@JS()
@anonymous
class Chart {
  external String get type;

  external factory Chart({String type});
}

@JS()
@anonymous
class DataLabels {
  external bool get enabled;

  external String get textAnchor;

  external num get offsetX;

  external num get offsetY;

  external Function get formatter;

  external factory DataLabels({String type});
}

@JS()
@anonymous
class Style {
  external String get fontSize;

  external List<String> get colors;

  external factory Style({String fontSize, List<String> colors});
}

@JS()
@anonymous
class DropShadow {
  external bool get enabled;

  external num get top;

  external num get left;

  external num get blur;

  external num get opacity;

  external factory DropShadow(
      {bool enabled, num top, num left, num blur, num opacity});
}

@JS()
@anonymous
class Animations {
  external bool get enabled;

  external String get easing;

  external num get speed;

  external AnimateGradually get animateGradually;

  external DynamicAnimation get dynamicAnimation;

  external factory Animations(
      {bool enabled,
      String easing,
      num speed,
      AnimateGradually animateGradually,
      DynamicAnimation dynamicAnimation});
}

@JS()
@anonymous
class AnimateGradually {
  external bool get enabled;

  external num get delay;

  external factory AnimateGradually({bool enabled, num delay});
}

@JS()
@anonymous
class DynamicAnimation {
  external bool get enabled;

  external num get speed;

  external factory DynamicAnimation({bool enabled, num speed});
}

@JS()
@anonymous
class Data {
  external String get name;

  external List get data;

  external factory Data({String name, List<int> data});
}

@JS()
@anonymous
class Xaxis {
  external List<String> get categories;

  external factory Xaxis({List<String> categories});
}
