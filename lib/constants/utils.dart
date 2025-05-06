import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/btn_w.dart';
import 'package:flutter_amazon_clone/features/account/service/account_service.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      content: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 20), // slide up from 20px
              child: child,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.blue],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

Future<List<File>> pickImages(BuildContext context) async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
      showSnackBar(context, 'Images picked: ${images.length}');
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return images;
}

Future<void> logOut(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log Out'),
        content: const SizedBox(
          width: double.infinity,
          child: Text(
            'Do you want to log out?',
            style: TextStyle(fontSize: 23),
          ),
        ),
        actions: [
          BtnW(
            btnText: 'Yes',
            borderRadius: 23,
            onTap: () {
              AccountService().logOut(context);
              Navigator.pop(context); // Close dialog
            },
          ),
          BtnW(
            btnText: 'No',
            borderRadius: 23,
            onTap: () => Navigator.pop(context), // Close dialog
          ),
        ],
      );
    },
  );
}
