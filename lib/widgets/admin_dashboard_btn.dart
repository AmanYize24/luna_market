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
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          gradient:
              const LinearGradient(colors: [Colors.tealAccent, Colors.white]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              style: GoogleFonts.inter(
                  color: Colors.pinkAccent,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
              btnName),
        ),
      ),
    ),
  );
}
