import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/extensions/http_extension.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  try {
    // Check if the request was successful
    if (response.isOk) {
      onSuccess();
    } 
    // Handle bad request (400)
    else if (response.isBadRequest) {
      // Try to decode the error message or show a fallback
      var errorMsg = jsonDecode(response.body)['msg'] ?? 'Bad request error';
      showSnackBar(context, errorMsg);
    } 
    // Handle server error (500)
    else if (response.isServerError) {
      var errorMsg = jsonDecode(response.body)['error'] ?? 'Server error';
      showSnackBar(context, errorMsg);
    } 
    // Handle other status codes (e.g., Unauthorized, Forbidden, Not Found)
    else if (response.statusCode == 401) {
      showSnackBar(context, 'Unauthorized request. Please log in again.');
    } else if (response.statusCode == 403) {
      showSnackBar(context, 'Access forbidden.');
    } else if (response.statusCode == 404) {
      showSnackBar(context, 'Resource not found.');
    } else {
      // Generic error message for other status codes
      showSnackBar(context, 'An error occurred. Please try again.');
    }
  } catch (e) {
    // Handle any exceptions while decoding the response body
    showSnackBar(context, 'An unexpected error occurred. Please try again.');
  }
}
