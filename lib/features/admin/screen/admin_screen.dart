import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/bottom_navigation_bar_w.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/custom_app_bar_w.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  static const routeName = 'adminPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavigationBarW(),
      appBar: CustomAppBarW(),
      body: Center(
        child: Text(routeName),
      ),
    );
  }
}
