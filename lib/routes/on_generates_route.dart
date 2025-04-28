import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/bottom_navigation_bar_w.dart';
import 'package:flutter_amazon_clone/features/account/screens/account_screen.dart';
import 'package:flutter_amazon_clone/features/address/screen/address_screen.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/screen/add_product_screen.dart';
import 'package:flutter_amazon_clone/features/admin/screen/admin_screen.dart';
import 'package:flutter_amazon_clone/features/admin/screen/product_screen.dart';
import 'package:flutter_amazon_clone/features/ai_product_detail/screen/ai_product_detail_screen.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/features/cart/screen/cart_screen.dart';
import 'package:flutter_amazon_clone/features/home/screen/category_deals_screen.dart';
import 'package:flutter_amazon_clone/features/home/screen/home_screen.dart';
import 'package:flutter_amazon_clone/features/order_details/screen/order_detail_screen.dart';
import 'package:flutter_amazon_clone/features/product_detail/screens/product_detail_screen.dart';
import 'package:flutter_amazon_clone/features/search/screen/search_screen.dart';

import '../features/account/model/order.dart';

Route<dynamic>? onGenerateRoutes(RouteSettings setting) {
  return switch (setting.name) {
    HomeScreen.routeName =>
      FadeTransitionRoute(page: const HomeScreen(), setting: setting),
    BottomNavigationBarW.routeName =>
      FadeTransitionRoute(page: const BottomNavigationBarW(), setting: setting),
    AuthScreen.routeName =>
      FadeTransitionRoute(page: const AuthScreen(), setting: setting),
    AccountScreen.routeName =>
      FadeTransitionRoute(page: const AccountScreen(), setting: setting),
    AdminScreen.routeName =>
      FadeTransitionRoute(page: const AdminScreen(), setting: setting),
    ProductScreen.routeName =>
      FadeTransitionRoute(page: const ProductScreen(), setting: setting),
    AddProductScreen.routeName =>
      FadeTransitionRoute(page: const AddProductScreen(), setting: setting),
    CategoryDealsScreen.routeName => FadeTransitionRoute(
        page: CategoryDealsScreen(
          category: setting.arguments as String,
        ),
        setting: setting),
    SearchScreen.routeName => FadeTransitionRoute(
        page: SearchScreen(
          searchQuery: setting.arguments as String,
        ),
        setting: setting),
    ProductDetailScreen.routeName => FadeTransitionRoute(
        page: ProductDetailScreen(
          product: setting.arguments as Product,
        ),
        setting: setting),
    CartScreen.routeName =>
      FadeTransitionRoute(page: const CartScreen(), setting: setting),
    AddressScreen.routeName => FadeTransitionRoute(
        page: AddressScreen(
          totalAmount: setting.arguments.toString(),
        ),
        setting: setting),
    OrderDetailScreen.routeName => FadeTransitionRoute(
        page: OrderDetailScreen(
          order: setting.arguments as Order,
        ),
        setting: setting),
    AiProductDetailScreen.route => FadeTransitionRoute(
        page:  AiProductDetailScreen(
            senderMessage: setting.arguments as ({String promptMessage}),
            receiverMessage: text),
      ),
    _ => MaterialPageRoute(
        settings: setting,
        builder: (_) => ErrorWidget(
          'Page not found',
        ),
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

const text = '''fetch(url, {
  method: "POST",        // Method is POST (not GET)
  headers: {             // Headers to describe the request
    "Authorization": "...",
    "Content-Type": "application/json"
  },
  body: JSON.stringify({ // The data you're sending, converted into a JSON string
    model: "...",
    messages: [...]
  })
});''';
