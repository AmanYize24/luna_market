import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart';

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
    required String location,
    required context}) async {
  if (name != '' && location != '' && phone != '' && paymentMethod != '') {
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

    try {
      await EmailJS.send(
        'service_yqd9pkt',
        'template_gwyv5jn',
        {
          'to_email': email,
          'to_name': name,
          'from_name': 'Luna Market',
          'total_price': total,
          'message':
              "your order has been submitted to luna market please don't lose this mail as it is used for tracking your order thank you",
        },
        const Options(
          publicKey: 'vOPqZZfL50EthRA34',
          privateKey: 'WGIwUr_a5hImQiFDjwqBj',
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
  } else {
    showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              title: const Text('form error'),
              content: const Text('please fill all the forms'),
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
