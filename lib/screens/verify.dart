import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:luna_market/screens/home_screen.dart';
import 'package:luna_market/widgets/box.dart';

import '../auth/auth.dart';
import 'dart:async';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  String? userEmail = '';
  Timer? timer;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      userEmail = FirebaseAuth.instance.currentUser?.email;
    } else {
      userEmail = "no email found";
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 3), (Timer t) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
        t.cancel();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
    var textStyle = const TextStyle(fontSize: 20);

    return FirebaseAuth.instance.currentUser!.isAnonymous == true
        ? const HomeScreen()
        : Scaffold(
            body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2022/01/25/12/53/tree-6966126_960_720.jpg'))),
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                box(0, 300),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      style: textStyle, "you need to verify email to continue"),
                ),
                box(0, 30),
                Align(
                  alignment: Alignment.center,
                  child: Text(style: textStyle, "$userEmail"),
                ),
                box(0, 30),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await verifyEmail();
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: loading
                          ? const CircularProgressIndicator()
                          : Text(style: textStyle, "Send Verfication Mail"),
                    ),
                  ),
                ),
              ],
            ),
          ));
  }
}
