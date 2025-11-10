import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TaskPieChart extends StatelessWidget {
  final int completed;
  final int timely;
  final int overdue;

  const TaskPieChart({
    super.key,
    required this.completed,
    required this.timely,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    final total = completed + timely + overdue;

    if (total == 0) {
      return Center(child: Text("No tasks yet"));
    }

    // Pie sections
    final sections = [
      PieChartSectionData(
        value: completed.toDouble(),
        color: Colors.green,
        radius: 60,
        title: '$completed',
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: timely.toDouble(),
        color: Colors.blue,
        radius: 60,
        title: '$timely',
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: overdue.toDouble(),
        color: Colors.red,
        radius: 60,
        title: '$overdue',
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 230, // bigger height
          child: PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(Colors.green, 'Completed'),
            const SizedBox(width: 16),
            _buildLegendItem(Colors.blue, 'Timely'),
            const SizedBox(width: 16),
            _buildLegendItem(Colors.red, 'Overdue'),
          ],
        ),
        const Gap(16),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
