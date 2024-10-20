import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/err/error_handling.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../auth/providers/user_auth_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProduct(
      {required BuildContext context, required String category}) async {
    final userProvider = context.read<UserAuthProvider>();
    List<Product> productList = [];
    try {
      var response = await get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(response.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDay(
      {required BuildContext context}) async {
    final userProvider = context.read<UserAuthProvider>();
    Product product = Product(
        name: '',
        description: '',
        price: 0,
        quantity: 0,
        category: '',
        images: []);
    try {
      var response = await get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          product = Product.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
