import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      // duration: const Duration(milliseconds: 800),
      duration: const Duration(seconds: 5),
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
