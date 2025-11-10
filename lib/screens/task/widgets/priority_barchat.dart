import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriorityBarChart extends StatelessWidget {
  final int high;
  final int medium;
  final int low;

  const PriorityBarChart({
    super.key,
    required this.high,
    required this.medium,
    required this.low,
  });

  @override
  Widget build(BuildContext context) {
    final maxY =
        [high, medium, low].reduce((a, b) => a > b ? a : b).toDouble() + 3;

    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text(
                        'High',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    case 1:
                      return const Text(
                        'Medium',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    case 2:
                      return const Text(
                        'Low',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBar(0, high.toDouble(), Colors.red, Colors.redAccent),
            _buildBar(
              1,
              medium.toDouble(),
              Colors.orange,
              Colors.deepOrangeAccent,
            ),
            _buildBar(2, low.toDouble(), Colors.green, Colors.lightGreen),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(
    int x,
    double y,
    Color startColor,
    Color endColor,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(8),
          width: 22,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: y + 2, // subtle background behind the bar
            color: Colors.grey.withValues(alpha: 0.2),
          ),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }
}
