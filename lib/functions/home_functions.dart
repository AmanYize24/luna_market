import "package:flutter/material.dart";
import "package:luna_market/screens/wrapper.dart";

void signOutFromHome(context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Wrapper()));
}
