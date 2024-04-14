// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class WrapperBtn extends StatefulWidget {
  final String firstText;
  final String secondText;
  dynamic navigateTo;

  WrapperBtn(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.navigateTo});

  @override
  State<WrapperBtn> createState() => _WrapperBtnState();
}

class _WrapperBtnState extends State<WrapperBtn> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 350,
        height: 65,
        child: ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              widget.navigateTo();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    style: GoogleFonts.ubuntu(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    "${widget.firstText} ",
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    style: GoogleFonts.notoSerifEthiopic(
                      color: Colors.black,
                    ),
                    "(${widget.secondText})",
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
