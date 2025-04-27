import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
    log('$e');
  }
  return images;
}
