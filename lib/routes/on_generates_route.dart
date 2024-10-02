import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter_amazon_clone/features/account/screens/account_screen.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/screen/home/home_screen.dart';

Route<dynamic>? onGenerateRoutes(RouteSettings setting) {
  return switch (setting.name) {
    HomeScreen.pageName =>
      FadeTransitionRoute(setting: setting, page: const HomeScreen()),
    BottomBar.pageName =>
      FadeTransitionRoute(page: const BottomBar(), setting: setting),
    AuthScreen.pageName =>
      FadeTransitionRoute(page: const AuthScreen(), setting: setting),
    AccountScreen.pageName =>
      FadeTransitionRoute(page: const AccountScreen(), setting: setting),
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
