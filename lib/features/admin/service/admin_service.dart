import 'dart:convert';
import 'dart:developer'; // Import the log function for debugging
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/err/error_handling.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/features/account/model/order.dart';
import 'package:flutter_amazon_clone/features/admin/controller/bloc/admin_bloc.dart';
import 'package:flutter_amazon_clone/features/admin/model/product.dart';
import 'package:flutter_amazon_clone/features/admin/model/sales.dart';
import 'package:flutter_amazon_clone/features/auth/providers/user_auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AdminService with ChangeNotifier {
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = context.read<UserAuthProvider>();
    final cloudinary = CloudinaryPublic('dctxcupgb', 'pabqfkte');

    try {
      List<String> imageUrls = [];

      log('Starting image upload'); // Add a log for debugging

      // Upload all images to Cloudinary in parallel
      for (var image in images) {
        log('Uploading image: ${image.path}'); // Log each image upload
        final uploadResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: name),
        );
        imageUrls.add(uploadResponse.secureUrl);
        log('Image uploaded, URL: ${uploadResponse.secureUrl}'); // Log successful upload
      }

      log('All images uploaded, preparing product object'); // Log after images are uploaded

      // After all images are uploaded, create the product object
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls, // Set the uploaded image URLs
      );

      log('Sending product data to server: ${product.toJson()}'); // Log the product data

      // Make the POST request to your server
      var response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
        body: product.toJson(), // Convert product to JSON
      );

      log('Received response with status code: ${response.statusCode}'); // Log the status code

      // Handle HTTP error response
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product added successfully');
          context.read<AdminBloc>().images.clear();
          Navigator.pop(context);
        },
      );
      notifyListeners();
    } catch (e) {
      log('Error occurred: $e'); // Log any caught error
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(
    BuildContext context,
  ) async {
    final userProvider = context.read<UserAuthProvider>();
    List<Product> productList = [];
    try {
      var response = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
      );
      notifyListeners();

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
      notifyListeners();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = context.read<UserAuthProvider>();

    try {
      // Make the POST request to your server
      var response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}), // Convert product to JSON
      );

      log('Received response with status code: ${response.statusCode}'); // Log the status code

      // Handle HTTP error response
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'Deleted');

          // Close the screen on success
        },
      );
    } catch (e) {
      log('Error occurred: $e'); // Log any caught error
      // Show error message if an exception occurs
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = context.read<UserAuthProvider>();
    List<Order> orderList = [];
    try {
      final response =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        xToken: userProvider.user.token
      });
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(response.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      log('${e}error service');
    }

    return orderList;
  }

  void changesOrderStatus(
      {required BuildContext context,
      required int status,
      required VoidCallback onSuccess,
      required Order order}) async {
    final userProvider = context.read<UserAuthProvider>();
    try {
      var response = await post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          xToken: userProvider.user.token
        },
        body: jsonEncode(
          {'id': order.id, 'status': status},
        ),
      );
      httpErrorHandle(
          response: response, context: context, onSuccess: onSuccess);
    } catch (e) {
      log('error in changes order status');
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserAuthProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales(label: 'Mobiles', earning: response['mobileEarnings']),
            Sales(label: 'Essentials', earning: response['essentialEarnings']),
            Sales(label: 'Books', earning: response['booksEarnings']),
            Sales(label: 'Appliances', earning: response['applianceEarnings']),
            Sales(label: 'Fashion', earning: response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
