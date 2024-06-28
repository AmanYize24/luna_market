import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget adminDashboardBtn({required String btnName, required onPress}) {
  return GestureDetector(
    onTap: () {
      onPress();
    },
    child: Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 185,
        height: 125,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(255, 255, 255, 0.5),
            Color.fromRGBO(255, 255, 255, 0.8)
          ]),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
              btnName),
        ),
      ),
    ),
  );
}
