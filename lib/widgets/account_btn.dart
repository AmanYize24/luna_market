import 'package:flutter/material.dart';

Widget accountBtn({required Widget choiceText, required Function userChoice}) {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 350,
      height: 65,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          userChoice();
        },
        child: choiceText,
      ),
    ),
  );
}
