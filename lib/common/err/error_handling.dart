import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/extensions/http_extension.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  if (response.isOk) {
    onSuccess();
  } else if (response.isBadRequest) {
    showSnackBar(context, jsonDecode(response.body)['msg']);
  } else if (response.isServerError) {
    showSnackBar(context, jsonDecode(response.body)['error']);
  }else{
    showSnackBar(context, 'An error occurred. Please try again.');
  }
}
