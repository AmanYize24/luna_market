import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/widgets/box.dart';

class UserRequestDetails extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String issue;
  const UserRequestDetails(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.issue});

  @override
  State<UserRequestDetails> createState() => _UserRequestDetailsState();
}

class _UserRequestDetailsState extends State<UserRequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Request Details"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2017/12/22/11/09/schilthorn-3033448_1280.jpg'))),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              width: double.infinity,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        "Name: "),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        widget.name),
                  ),
                ],
              ),
            ),
            box(0, 20),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              width: double.infinity,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        "Email: "),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        widget.email),
                  ),
                ],
              ),
            ),
            box(0, 20),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              width: double.infinity,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        "Phone: "),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        widget.phone),
                  ),
                ],
              ),
            ),
            box(0, 20),
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(color: Colors.grey)),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Text(
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                      "Issue: "),
                  Text(
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.white),
                      widget.issue),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
