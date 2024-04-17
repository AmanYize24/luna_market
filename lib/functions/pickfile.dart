import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<PlatformFile> imgPath({required context}) async {
  try {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(withData: true);
    if (result != null) {
      PlatformFile file = PlatformFile(
          name: result.files.first.name,
          bytes: result.files.first.bytes,
          size: result.files.first.size);

      return file;
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
  return PlatformFile(name: '', bytes: null, size: 0);
}

Future<String> pickFile({required file, required context}) async {
  final checkoutRef = FirebaseStorage.instance.ref().child('Checkout');
  print('The path is ${file.path}');
  try {
    final uploadRef = File(file.bytes);

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
