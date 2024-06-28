import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna_market/screens/support.dart';

Future<List> getSupport(
    {required String email, required String password, required context}) async {
  List support = await FirebaseFirestore.instance
      .collection("support")
      .get()
      .then((value) {
    return value.docs;
  });
  for (int i = 0; i < support.length; i++) {
    if (email == support[i]["email"] && password == support[i]["password"]) {
      try {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Support()));
      } catch (e) {
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: const Text("support sign in error"),
                  content: Text("$e"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"))
                  ],
                )));
      }
    }
  }
  return support;
}

Future<List> getUserRequests({required context}) async {
  try {
    List userRequests = await FirebaseFirestore.instance
        .collection("customer service")
        .get()
        .then(
      (value) {
        return value.docs;
      },
    );
    return userRequests;
  } catch (e) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("get user request error"),
              content: Text("$e"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"))
              ],
            )));
  }
  return [];
}

Future<bool> deleteUserRequest(
    {required String email, required context}) async {
  try {
    await FirebaseFirestore.instance
        .collection("customer service")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        if (email == value.docs[i]["email"]) {
          FirebaseFirestore.instance
              .collection('customer service')
              .doc(value.docs[i].id)
              .delete();
          return true;
        }
      }
    });
  } catch (e) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("get user request error"),
              content: Text("$e"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"))
              ],
            )));
  }
  return false;
}
