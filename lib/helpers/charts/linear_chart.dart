import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:flutter/material.dart';

class SimpleLineChart1 extends StatefulWidget {
  @override
  _SimpleLineChart1State createState() => _SimpleLineChart1State();
}

class AxisTheme {
  static charts.RenderSpec<num> axisThemeNum() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
    );
  }

  static charts.RenderSpec<DateTime> axisThemeDateTime() {
    return charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.gray.shade500,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.transparent,
      ),
    );
  }
}

class _SimpleLineChart1State extends State<SimpleLineChart1> {
  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      _createSampleData(),
      behaviors: [
        charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer("sup?"))
      ],
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
          if (model.hasDatumSelection)
            print(model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index));
        })
      ],
    );
  }

  List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];
    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  String text;

  CustomCircleSymbolRenderer(this.text);

  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      charts.Color fillColor,
      charts.Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: charts.Color.white);
    var textStyle = style.TextStyle();
    textStyle.color = charts.Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(TextElement(text, style: textStyle), (bounds.left).round(),
        (bounds.top - 28).round());
  }
}

//class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
//  @override
//  void paint(ChartCanvas canvas, Rectangle<num> bounds,
//      {List<int> dashPattern,
//      Color fillColor,
//      Color strokeColor,
//      double strokeWidthPx}) {
//    super.paint(canvas, bounds,
//        dashPattern: dashPattern,
//        fillColor: fillColor,
//        strokeColor: strokeColor,
//        strokeWidthPx: strokeWidthPx);
//    canvas.drawRect(
//        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
//            bounds.height + 10),
//        fill: Color.white);
//    var textStyle = style.TextStyle();
//    textStyle.color = Color.black;
//    textStyle.fontSize = 15;
//    canvas.drawText(TextElement("1", style: textStyle), (bounds.left).round(),
//        (bounds.top - 28).round());
//  }
//}

class LinearSales {
  final int year;
  final int sales;
  LinearSales(this.year, this.sales);
}
