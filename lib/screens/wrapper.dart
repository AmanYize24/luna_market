import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:luna_market/screens/verify.dart';

import '../screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/auth.dart';
import 'package:luna_market/widgets/box.dart';
import 'package:luna_market/widgets/wrapper_btn.dart';
import '../functions/wrapper_functions.dart';
import '../colors/wrapper_color.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }

  Widget wrap() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: wrapperBackground,
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 300,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/luna-market-logo.jfif"),
                ),
              ),
              box(0, 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  style: GoogleFonts.notoSerifEthiopic(fontSize: 25),
                  "ሰላም",
                ),
              ),
              box(0, 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  style: GoogleFonts.merienda(fontSize: 25),
                  "Welcome To Luna Market",
                ),
              ),
              box(0, 40),
              WrapperBtn(
                firstText: "Create Account",
                secondText: "መለያ መፍጠር",
                navigateTo: () {
                  goToSignUp(context);
                },
              ),
              box(0, 25),
              WrapperBtn(
                firstText: "Login",
                secondText: "ግባ",
                navigateTo: () {
                  goToSignIn(context);
                },
              ),
              box(0, 25),
              WrapperBtn(
                firstText: loading ? 'loading' : "Anonymous",
                secondText: "ስም-አልባ",
                navigateTo: () async {
                  setState(() {
                    loading = true;
                  });
                  await anonymousSignIn(context);
                  setState(() {
                    loading = false;
                  });
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser?.emailVerified == true) {
      return const HomeScreen();
    } else if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser?.emailVerified == false) {
      return const Verify();
    } else {
      return wrap();
    }
  }
}
