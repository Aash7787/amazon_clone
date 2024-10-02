import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/err/error_handling.dart';
import 'package:flutter_amazon_clone/features/home/widgets/bottom_bar.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';

import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/auth/models/user.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          address: '',
          type: '',
          email: email,
          token: '');
      var response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created successfully !');
        },
      );
      log(response.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Ensure the widget is still mounted before using context
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          context.read<UserAuthProvider>().setUser(response.body);
          await pref.setString(xToken, jsonDecode(response.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.pageName,
            (route) => false,
          );
          showSnackBar(context, 'Welcome $email');
        },
      );

      log(response.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString(xToken);
      if (token == null) {
        pref.setString(xToken, '');
      }

      var tokenResponse = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            xToken: token!
          });

      var response = jsonDecode(tokenResponse.body);

      if (response == true) {
        var userResponse = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            xToken: token
          },
        );
        var userAuthProvider = context.read<UserAuthProvider>();
        userAuthProvider.setUser(userResponse.body);
      }

      log(response.body);
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
}
