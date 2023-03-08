import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class JobApplicationChart extends StatefulWidget {
  const JobApplicationChart({Key? key}) : super(key: key);

  @override
  JobApplicationChartState createState() => JobApplicationChartState();
}

class JobApplicationChartState extends State<JobApplicationChart> {
  final dataMap = <String, double>{
    "Applied": 3,
    "Under Review": 2,
    "Offered": 1,
    "Rejected": 3,
    "Not Started": 5
  };
  final colorList = <Color>[
    Colors.deepPurple,
    Colors.amber.shade800,
    Colors.green.shade800,
    Colors.red.shade800,
    const Color.fromRGBO(223, 223, 223, 1),
  ];
  final ChartType? _chartType = ChartType.ring;
  final double? _ringStrokeWidth = 32;
  final double? _chartLegendSpacing = 32;

  final bool _showLegendsInRow = false;
  final bool _showLegends = true;

  final bool _showChartValueBackground = true;
  final bool _showChartValues = true;
  final bool _showChartValuesOutside = false;

  final LegendPosition? _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
      colorList: colorList,
      initialAngleInDegree: -90,
      chartType: _chartType!,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: BoxShape.circle,
        legendTextStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        chartValueBackgroundColor: Colors.white,
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: true,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.white,
    );
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 32,
      ),
      child: chart,
    );
  }
}
