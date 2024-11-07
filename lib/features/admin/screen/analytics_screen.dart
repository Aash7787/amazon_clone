import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/model/sales.dart';
import 'package:flutter_amazon_clone/features/admin/service/admin_service.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/category_products_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final adminServices = AdminService();
  int? totalSales;
  List<Sales>? earnings;
  List<BarChartGroupData> barData = [];
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(
                  barGroupsList: barData,
                ),
              ),
            ],
          );
  }
  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    barData = _generateBarData(earnings!);
    setState(() {});
  }

  List<BarChartGroupData> _generateBarData(List<Sales> earnings) {
    return earnings.asMap().entries.map((entry) {
      int index = entry.key;
      Sales sale = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: sale.earning.toDouble(),
            color: Colors.blue,
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }
}
