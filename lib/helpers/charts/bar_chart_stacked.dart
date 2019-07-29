import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Bar chart example
import 'package:flutter/material.dart';

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

class StackedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedBarChart(this.seriesList, {this.animate});

  /// Creates a stacked [BarChart] with sample data and no transition.
  factory StackedBarChart.withSampleData() {
    return new StackedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
      rtlSpec: charts.RTLSpec(axisDirection: charts.AxisDirection.reversed),
//      defaultRenderer: new BarRendererConfig<String>(
//        strokeWidthPx: 4,
//        barRendererDecorator: CustomBarLabelDecorator<String>(
//            labelAnchor: CustomBarLabelAnchor.end),
//      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('7-19', 5),
      new OrdinalSales('7-20', 25),
      new OrdinalSales('7-21', 100),
      new OrdinalSales('7-22', 75),
      new OrdinalSales('7-23', 15),
      new OrdinalSales('7-24', 25),
      new OrdinalSales('7-25', 85),
    ];

    final tableSalesData = [
      new OrdinalSales('7-19', 5),
      new OrdinalSales('7-20', 25),
      new OrdinalSales('7-21', 10),
      new OrdinalSales('7-22', 25),
      new OrdinalSales('7-23', 85),
      new OrdinalSales('7-24', 45),
      new OrdinalSales('7-25', 75),
    ];

    final mobileSalesData = [
      new OrdinalSales('7-19', 15),
      new OrdinalSales('7-20', 90),
      new OrdinalSales('7-21', 50),
      new OrdinalSales('7-22', 25),
      new OrdinalSales('7-23', 45),
      new OrdinalSales('7-24', 55),
      new OrdinalSales('7-25', 35),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (OrdinalSales sales, _) =>
            charts.MaterialPalette.gray.shade600,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        colorFn: (OrdinalSales sales, _) =>
            charts.MaterialPalette.gray.shade400,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
        colorFn: (OrdinalSales sales, _) =>
            charts.MaterialPalette.gray.shade800,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
