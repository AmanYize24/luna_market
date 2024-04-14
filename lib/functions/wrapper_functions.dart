import "package:flutter/material.dart";
import 'package:luna_market/screens/login_screen.dart';
import 'package:luna_market/screens/sign_up.dart';
import '../screens/home_screen.dart';

void goToAnonymous(context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
}

void goToSignIn(context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
}

void goToSignUp(context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
}
