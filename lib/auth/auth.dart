import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:luna_market/screens/home_screen.dart';
import 'package:luna_market/screens/verify.dart';

final user = FirebaseAuth.instance.currentUser;
var isEmailVerified = user!.emailVerified;
getCurrentUser() {
  if (user != null) {
    // Name, email address, and profile photo URL
  }
}

Future<void> verifyEmail() async {
  await FirebaseAuth.instance.currentUser?.sendEmailVerification();
}

Future<void> createUser(
    {required String email,
    required String password,
    required String confirmPassword,
    required String displayName,
    required context}) async {
  if (password == confirmPassword) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
      await FirebaseFirestore.instance
          .collection('user')
          .add({'email': FirebaseAuth.instance.currentUser!.email, 'cart': []});
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Verify()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  content: Text('The password provided is too weak.'),
                ));
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  content: Text('The account already exists for that email.'),
                ));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text('unknown error'),
              ));
    }
  } else {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("password's don't match"),
            ));
  }
}

Future<void> signOut(context) async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('error'),
              content: const Text("password's don't match"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('cancel'))
              ],
            ));
  }
}

Future<void> anonymousSignIn(context) async {
  try {
    await FirebaseAuth.instance.signInAnonymously();

    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text('signed in with temporary account'),
            ));
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  content: Text(
                      "Anonymous auth hasn't been enabled for this project."),
                ));
        break;
      default:
        showDialog(
            context: context,
            builder: (context) => const AlertDialog(
                  content: Text("unknow error from anonymousSignIn"),
                ));
    }
  }
}

Future<void> signIn(
    {required String email, required String password, required context}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser?.emailVerified == true) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser?.emailVerified == false) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Verify()));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("no user found with this email"),
              ));
    } else if (e.code == 'wrong-password') {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                content: Text("wrong password"),
              ));
    }
  }
}
