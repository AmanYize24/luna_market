import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

Future<dynamic> imgPath({required context}) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      dynamic file =
          kIsWeb ? result.files.single.bytes : result.files.single.path;

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

Future<String> pickFile(
    {required dynamic file, required BuildContext context}) async {
  final String userEmail = FirebaseAuth.instance.currentUser!.email!;
  final Reference fileRef =
      FirebaseStorage.instance.ref().child('Checkout').child('$userEmail.png');

  try {
    UploadTask uploadTask;
    if (kIsWeb) {
      Uint8List fileBytes = file;
      print('Uploading to web');
      uploadTask = fileRef.putData(fileBytes);
    } else {
      File uploadFile = File(file);
      print('Uploading to mobile');
      uploadTask = fileRef.putFile(uploadFile);
    }

    // Wait for the upload to complete
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    print('File upload complete.');

    // Get the download URL
    String downloadURL = await fileRef.getDownloadURL();
    print('Download URL obtained: $downloadURL');
    return downloadURL;
  } on FirebaseException catch (e) {
    print('FirebaseException: $e');
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Firebase Error'),
        content: Text('$e'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  } catch (e) {
    print('Exception: $e');
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('An error occurred: $e'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Return an empty string if an error occurred
  return '';
}
