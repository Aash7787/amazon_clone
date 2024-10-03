import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/screen/admin_screen.dart';
import 'package:flutter_amazon_clone/features/admin/screen/posts_screen.dart';
import 'package:flutter_amazon_clone/features/home/widgets/bottom_navigation_bar_w.dart';
import 'package:flutter_amazon_clone/features/account/screens/account_screen.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/features/home/screen/home_screen.dart';

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
    PostsScreen.pageName =>
      FadeTransitionRoute(page: const PostsScreen(), setting: setting),
    _ => MaterialPageRoute(
        settings: setting,
        builder: (_) => ErrorWidget('Page not found'),
      )
  };
}

class FadeTransitionRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings setting;
  FadeTransitionRoute({required this.page, required this.setting})
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
