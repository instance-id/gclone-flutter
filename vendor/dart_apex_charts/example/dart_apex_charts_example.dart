import '../lib/dart_apex_charts.dart';

void main() {
  drawHorizontalBar();
  drawSimpleBar();
  drawSimplePie();
}

void drawHorizontalBar() {
  Map<String, dynamic> options = <String, dynamic>{
    'chart': {
      'type': 'bar',
    },
    'plotOptions': {
      'bar': {
        'horizontal': true,
      }
    },
    'dataLabels': {'enabled': false},
    'series': [
      {
        'data': [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380]
      }
    ],
    'xaxis': {
      'categories': [
        'South Korea',
        'Canada',
        'United Kingdom',
        'Netherlands',
        'Italy',
        'France',
        'Japan',
        'United States',
        'China',
        'Germany'
      ],
    },
    'yaxis': <String, dynamic>{},
    'tooltip': <String, dynamic>{}
  };
  ApexCharts chart = ApexCharts('#horizontalBar', options);
  chart.render();
}

void drawSimpleBar() {
  Map<String, dynamic> options = <String, dynamic>{
    'chart': {
      'height': 380,
      'type': 'bar',
    },
    'plotOptions': {
      'bar': {
        'distributed': true,
      }
    },
    'series': [
      {
        'data': [400, 430, 448, 470, 540, 580, 690, 1100]
      }
    ],
    'xaxis': {
      'categories': [
        'South Korea',
        'Canada',
        'United Kingdom',
        'Netherlands',
        'Italy',
        'France',
        'Japan',
        'United States'
      ],
      'labels': {
        'style': {
          'colors': [
            '#008FFB',
            '#00E396',
            '#FEB019',
            '#FF4560',
            '#775DD0',
            '#546E7A',
            '#26a69a',
            '#D10CE8'
          ]
        }
      }
    },
  };
  ApexCharts chart = ApexCharts('#simpleBar', options);
  chart.render();
}

void drawSimplePie() {
  Map<String, dynamic> options = <String, dynamic>{
    'chart': {
      'type': 'pie',
    },
    'series': [400, 430, 448, 470, 540, 580, 690, 1100],
    'labels': [
      'South Korea',
      'Canada',
      'United Kingdom',
      'Netherlands',
      'Italy',
      'France',
      'Japan',
      'United States'
    ]
  };
  ApexCharts chart = ApexCharts('#simplePie', options);
  chart.render();
}
