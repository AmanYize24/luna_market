import 'package:flutter/material.dart';

Widget wrapperInput(
    {required String hint,
    required bool hideText,
    required TextEditingController controller}) {
  return (Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 350,
      height: 60,
      child: TextField(
        controller: controller,
        obscureText: hideText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.tealAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    ),
  ));
}
