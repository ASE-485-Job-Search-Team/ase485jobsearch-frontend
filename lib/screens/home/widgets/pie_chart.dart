import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class JobApplicationChart extends StatefulWidget {
  final int? applied;
  final int? underReview;
  final int? offered;
  final int? rejected;
  final int? unknown;
  const JobApplicationChart(
      {Key? key,
      required this.applied,
      required this.underReview,
      required this.offered,
      required this.rejected,
      required this.unknown})
      : super(key: key);

  @override
  JobApplicationChartState createState() => JobApplicationChartState();
}

class JobApplicationChartState extends State<JobApplicationChart> {
  late Map<String, double> dataMap = <String, double>{
    "Applied": widget.applied!.toDouble(),
    "Under Review": widget.underReview!.toDouble(),
    "Offered": widget.offered!.toDouble(),
    "Rejected": widget.rejected!.toDouble(),
    "Unknown": widget.unknown!.toDouble(),
  };

  @override
  void initState() {
    super.initState();

    setState(() {
      dataMap = <String, double>{
        "Applied": widget.applied!.toDouble(),
        "Under Review": widget.underReview!.toDouble(),
        "Offered": widget.offered!.toDouble(),
        "Rejected": widget.rejected!.toDouble(),
        "Unknown": widget.unknown!.toDouble(),
      };
    });
  }

  final colorList = <Color>[
    Colors.deepPurple,
    Colors.amber.shade800,
    Colors.green.shade800,
    Colors.red.shade800,
    const Color.fromRGBO(223, 223, 223, 1),
  ];
  final ChartType _chartType = ChartType.ring;
  final double _ringStrokeWidth = 32;
  final double _chartLegendSpacing = 32;

  final bool _showLegendsInRow = false;
  final bool _showLegends = true;

  final bool _showChartValueBackground = true;
  final bool _showChartValues = true;
  final bool _showChartValuesOutside = false;

  final LegendPosition _legendPosition = LegendPosition.right;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
      colorList: colorList,
      initialAngleInDegree: -90,
      chartType: _chartType,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
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
        showChartValuesInPercentage: false,
        showChartValuesOutside: _showChartValuesOutside,
        decimalPlaces: 0,
      ),
      ringStrokeWidth: _ringStrokeWidth,
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
