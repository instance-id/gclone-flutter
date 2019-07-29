import 'package:charts_flutter/flutter.dart' as charts;

/// Bar chart example
import 'package:flutter/material.dart';

import 'custom_bar_label_decorator.dart';

/// Example of using a primary and secondary axis (left & right respectively)
/// for a set of grouped bars. This is useful for comparing Series that have
/// different units (revenue vs clicks by region), or different magnitudes (2017
/// revenue vs 1/1/2017 revenue by region).
///
/// The first series plots using the primary axis to position its measure
/// values (bar height). This is the default axis used if the measureAxisId is
/// not set.
///
/// The second series plots using the secondary axis due to the measureAxisId of
/// secondaryMeasureAxisId.
///
/// Note: primary and secondary may flip left and right positioning when
/// RTL.flipAxisLocations is set.
class BarChartWithSecondaryAxis extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final List<charts.Series> seriesList;
  final bool animate;

  BarChartWithSecondaryAxis(this.seriesList, {this.animate});

  factory BarChartWithSecondaryAxis.withSampleData() {
    return new BarChartWithSecondaryAxis(
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
      barGroupingType: charts.BarGroupingType.grouped,
      // It is important when using both primary and secondary axes to choose
      // the same number of ticks for both sides to get the gridlines to line
      // up.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 3)),
      secondaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 3)),
      defaultRenderer: new charts.BarRendererConfig(
        strokeWidthPx: 0.8,
      ),
      barRendererDecorator: CustomBarLabelDecorator<String>(labelPadding: 5),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      new OrdinalSales('7-19', 5000),
      new OrdinalSales('7-20', 25000),
      new OrdinalSales('7-21', 10000),
      new OrdinalSales('7-22', 25000),
      new OrdinalSales('7-23', 85000),
      new OrdinalSales('7-24', 45000),
      new OrdinalSales('7-25', 75000),
    ];

    final losAngelesSalesData = [
      new OrdinalSales('7-19', 5),
      new OrdinalSales('7-20', 25),
      new OrdinalSales('7-21', 10),
      new OrdinalSales('7-22', 25),
      new OrdinalSales('7-23', 85),
      new OrdinalSales('7-24', 45),
      new OrdinalSales('7-25', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Los Angeles Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: losAngelesSalesData,
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId)
      // Set the 'Los Angeles Revenue' series to use the secondary measure axis.
      // All series that have this set will use the secondary measure axis.
      // All other series will use the primary measure axis.
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
