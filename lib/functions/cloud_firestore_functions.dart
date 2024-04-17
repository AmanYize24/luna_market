import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseFirestore _cloudInstance = FirebaseFirestore.instance;

final _userRef = _cloudInstance.collection('user');

Future<void> addToCart(
    {required String email, required cartData, required context}) async {
  try {
    await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        if (querySnapshot.docs[i]['email'] ==
            FirebaseAuth.instance.currentUser!.email) {
          _userRef
              .doc(querySnapshot.docs[i].reference.path.split('/')[1])
              .update({
            'cart': FieldValue.arrayUnion([cartData])
          });
        }
      }
    });
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('item added to cart'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  } catch (e) {
    showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'))
              ],
              content: Text(e.toString()),
              title: const Text('error'),
            ));
  }
}

class CartProvider extends ChangeNotifier {
  Future<List> getCart(context) async {
    List cartList = [
      {'name': 'amane'}
    ];
    await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((QuerySnapshot value) {
      for (int i = 0; i < value.docs.length; i++) {
        if (value.docs[i]['email'] ==
            FirebaseAuth.instance.currentUser!.email) {
          if (value.docs[i]['email'] ==
              FirebaseAuth.instance.currentUser!.email) {
            try {
              cartList = List.from(value.docs[i]['cart']);
            } catch (e) {
              showDialog(
                  context: (context),
                  builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('cancel'))
                        ],
                        content: Text(e.toString()),
                        title: const Text('error'),
                      ));
            }
          }
        }
      }
    });

    return cartList;
  }
}

Future<void> removeFromCart({required obj, required context}) async {
  try {
    await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        if (querySnapshot.docs[i]['email'] ==
            FirebaseAuth.instance.currentUser!.email) {
          _userRef
              .doc(querySnapshot.docs[i].reference.path.split('/')[1])
              .update({
            'cart': FieldValue.arrayRemove([obj]),
          });
        }
      }
    });
  } catch (e) {
    showDialog(
        context: (context),
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'))
              ],
              content: Text(e.toString()),
              title: const Text('error'),
            ));
  }
}
