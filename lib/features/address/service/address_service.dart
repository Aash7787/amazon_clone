import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/err/error_handling.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/auth/models/user.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AddressService {
  void safeUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = context.read<UserAuthProvider>();
    try {
      var res = await post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token
        },
        body: jsonEncode(
          {'address': address},
        ),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var user = userProvider.user
              .copyWith(address: jsonDecode(res.body)['address']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    final userProvider = context.read<UserAuthProvider>();
    try {
      var response = await post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
        body: jsonEncode(
          {
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum
          },
        ),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, 'Error $e');
    }
  }
}
