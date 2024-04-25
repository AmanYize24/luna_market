import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<File> imgPath({required context}) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File("${result.files.single.path}");

      return file;
    }
  } catch (e) {
    showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              title: const Text('Error from Img Path'),
              content: Text('$e'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'))
              ],
            ));
  }
  return File('');
}

Future<String> pickFile({required file, required context}) async {
  final checkoutRef = FirebaseStorage.instance.ref().child('Checkout');

  try {
    final uploadRef = File(file.path);

    try {
      await checkoutRef
          .child('/${FirebaseAuth.instance.currentUser!.email}.png')
          .putFile(uploadRef);
      try {
        return checkoutRef
            .child('/${FirebaseAuth.instance.currentUser!.email}.png')
            .getDownloadURL();
      } catch (e) {
        showDialog(
            context: (context),
            builder: (context) => AlertDialog(
                  title: const Text('Error getting the img url'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Ok'))
                  ],
                ));
      }
    } on FirebaseException catch (e) {
      showDialog(
          context: (context),
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text('$e'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'))
                ],
              ));
    }
  } catch (e) {
    showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text('$e'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'))
              ],
            ));
  }
  return '';
}
