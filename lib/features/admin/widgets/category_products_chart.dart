import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<BarChartGroupData> barGroupsList;

  const CategoryProductsChart({
    super.key,
    required this.barGroupsList,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: barGroupsList
                .map((e) => e.barRods[0].toY)
                .reduce((a, b) => a > b ? a : b) +
            200,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${_getCategoryLabel(groupIndex)}\n\$${rod.toY.toInt()}',
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 500,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '\$${value.toInt()}',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final labels = [
                  'Mobiles',
                  'Essentials',
                  'Books',
                  'Appliances',
                  'Fashion'
                ];
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    labels[value.toInt()],
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: 500,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.15),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barGroupsList,
      ),
      swapAnimationDuration: const Duration(milliseconds: 600),
    );
  }

  // Helper function to get category label for the tooltip
  String _getCategoryLabel(int index) {
    switch (index) {
      case 0:
        return 'Mobiles';
      case 1:
        return 'Essentials';
      case 2:
        return 'Books';
      case 3:
        return 'Appliances';
      case 4:
        return 'Fashion';
      default:
        return '';
    }
  }
}
