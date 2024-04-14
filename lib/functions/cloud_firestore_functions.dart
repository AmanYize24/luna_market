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
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == FirebaseAuth.instance.currentUser!.email) {
          _userRef.doc(doc.reference.path.split('/')[1]).update({
            'cart': FieldValue.arrayUnion([cartData])
          });
        }
      });
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
      value.docs.forEach((doc) {
        if (doc['email'] == FirebaseAuth.instance.currentUser!.email) {
          try {
            cartList = List.from(doc['cart']);
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
      });
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
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == FirebaseAuth.instance.currentUser!.email) {
          _userRef.doc(doc.reference.path.split('/')[1]).update({
            'cart': FieldValue.arrayRemove([obj]),
          });
        }
      });
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
