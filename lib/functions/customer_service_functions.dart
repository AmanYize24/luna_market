import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<String> addAnIssue(
    {required String name,
    required String email,
    required String phone,
    required context,
    required String issue}) async {
  CollectionReference customerService =
      FirebaseFirestore.instance.collection("customer service");
  try {
    await customerService.add({
      "name": name,
      "email": email,
      "phone": phone,
      "issue": issue,
    });
    showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
              content: const Column(
                children: [
                  Text("request submitted "),
                  Text(
                      "we will review your request and get back to you as soon as possible"),
                ],
              ),
              title: const Text('success'),
            ));
    return "";
  } catch (e) {
    void showError() {
      showDialog(
          context: (context),
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'))
                ],
                content: Text("$e"),
                title: const Text('request form error'),
              ));
    }

    showError();
  }
  return "";
}
