import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

CollectionReference checkout =
    FirebaseFirestore.instance.collection('checkout');

Future<void> addToCheckout(
    {required String name,
    required String proofImg,
    required String email,
    required String phone,
    required String paymentMethod,
    required List cartData,
    required String total,
    required context}) async {
  try {
    checkout.add({
      'name': name,
      'payment proof': proofImg,
      'email': FirebaseAuth.instance.currentUser!.email,
      'phone': phone,
      "payment method": paymentMethod,
      'cart': cartData,
      'total': total,
    }).then(
      (value) => showDialog(
        context: (context),
        builder: (context) => AlertDialog(
          title: const Text('Order Submitted'),
          content: const Text('Wait for confirmation'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'))
          ],
        ),
      ),
    );
  } catch (e) {
    showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              title: const Text('error'),
              content: Text('$e'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  }
}
