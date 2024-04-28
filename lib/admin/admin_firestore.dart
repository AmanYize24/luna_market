import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('checkout');

Future<List> getData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  return allData;
}

Future<bool> deleteOrder({required String email, required context}) async {
  await FirebaseFirestore.instance
      .collection('checkout')
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (email == querySnapshot.docs[i]["email"]) {
        try {
          FirebaseFirestore.instance
              .collection("checkout")
              .doc(querySnapshot.docs[i].id)
              .delete();
          return true;
        } catch (e) {
          showDialog(
              context: (context),
              builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('ok'))
                    ],
                    content: Text("$e"),
                    title: const Text('delete order error'),
                  ));
        }
      }
    }
  });

  return false;
}
