import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luna_market/admin/screens/admin_home.dart';

CollectionReference adminRef = FirebaseFirestore.instance.collection('admin');

Future<void> getAdmin(
    {required String emailIn,
    required String passwordIn,
    required context}) async {
  String email = '';
  String password = '';
  try {
    await adminRef.get().then((QuerySnapshot querySnapshot) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        email = querySnapshot.docs[i]['email'];
        password = querySnapshot.docs[i]['password'];
        if (emailIn == email && passwordIn == password) {
          try {
            Future<void> signInAdmin() async {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AdminHome(),
                ));
              }
            }

            signInAdmin();
          } catch (e) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('couldnt sign in'),
                      content: const Text('please try again'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ok'))
                      ],
                    ));
          }
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AdminHome(),
            ));
          }
        } else {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('account is not correct'),
                    content: const Text('please try again'),
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
    });
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("error from get admin"),
        content: Text('$e'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'))
        ],
      ),
    );
  }
}
