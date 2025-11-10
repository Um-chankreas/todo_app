import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TasksLineChart extends StatelessWidget {
  final Map<String, int> data; // key: day, value: task count

  const TasksLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    final labels = <String>[];

    int i = 0;
    data.forEach((key, value) {
      spots.add(FlSpot(i.toDouble(), value.toDouble()));
      labels.add(key);
      i++;
    });

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < labels.length) {
                    return Text(labels[index]);
                  }
                  return Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
