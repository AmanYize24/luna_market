import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/widgets/box.dart';

Widget card(
    {required String name,
    required String price,
    required String imgUrl,
    required String description}) {
  return Container(
    width: 180,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10)),
    child: ListView(
      children: [
        Container(
          width: 180,
          height: 150,
          padding: const EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(imgUrl),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          width: 180,
          height: 90,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    name),
              ),
              box(0, 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                    price),
              ),
              box(0, 10),
            ],
          ),
        )
      ],
    ),
  );
}
