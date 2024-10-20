import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/err/error_handling.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ProductDetailService {
  void removeToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = context.read<UserAuthProvider>();
    try {
      var response = await delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          var user = userProvider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userProvider.setUserFromModel(user);
          showSnackBar(context, 'Removed to cart');
        },
      );
    } catch (e) {
      showSnackBar(context, 'Something went wrong');
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = context.read<UserAuthProvider>();
    try {
      var response = await post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
        body: jsonEncode(
          {'id': product.id},
        ),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          var user = userProvider.user.copyWith(
            cart: jsonDecode(response.body)['cart'],
          );
          userProvider.setUserFromModel(user);
          showSnackBar(context, 'Add to cart 😃');
        },
      );
    } catch (e) {
      showSnackBar(context, 'Something went wrong');
    }
  }

  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = context.read<UserAuthProvider>();
    try {
      var response = await post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
        body: jsonEncode(
          {'id': product.id, 'rating': rating},
        ),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Thank you for your feedback');
        },
      );
    } catch (e) {
      showSnackBar(context, 'Something went wrong');
    }
  }
}
