import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/screen/add_product_screen.dart';
import 'package:flutter_amazon_clone/features/admin/screen/admin_screen.dart';
import 'package:flutter_amazon_clone/features/admin/screen/product_screen.dart';
import 'package:flutter_amazon_clone/features/home/screen/category_deals_screen.dart';
import 'package:flutter_amazon_clone/features/home/widgets/bottom_navigation_bar_w.dart';
import 'package:flutter_amazon_clone/features/account/screens/account_screen.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/features/home/screen/home_screen.dart';
import 'package:flutter_amazon_clone/features/search/screen/search_screen.dart';

Route<dynamic>? onGenerateRoutes(RouteSettings setting) {
  return switch (setting.name) {
    HomeScreen.pageName =>
      FadeTransitionRoute(page: const HomeScreen(), setting: setting),
    BottomNavigationBarW.pageName =>
      FadeTransitionRoute(page: const BottomNavigationBarW(), setting: setting),
    AuthScreen.pageName =>
      FadeTransitionRoute(page: const AuthScreen(), setting: setting),
    AccountScreen.pageName =>
      FadeTransitionRoute(page: const AccountScreen(), setting: setting),
    AdminScreen.pageName =>
      FadeTransitionRoute(page: const AdminScreen(), setting: setting),
    ProductScreen.pageName =>
      FadeTransitionRoute(page: const ProductScreen(), setting: setting),
    AddProductScreen.pageName =>
      FadeTransitionRoute(page: const AddProductScreen(), setting: setting),
    CategoryDealsScreen.pageName => FadeTransitionRoute(
        page: CategoryDealsScreen(
          category: setting.arguments as String,
        ),
        setting: setting),
    SearchScreen.pageName => FadeTransitionRoute(
        page: SearchScreen(
          searchQuery: setting.arguments as String,
        ),
        setting: setting),
    _ => MaterialPageRoute(
        settings: setting,
        builder: (_) => ErrorWidget('Page not found'),
      )
  };
}

class FadeTransitionRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings? setting;
  FadeTransitionRoute({required this.page, this.setting})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
                      opacity: animation,
                      child: page,
                    ),
            settings: setting);
}
