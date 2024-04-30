import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      "Name: "),
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      widget.name),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      "Email: "),
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      widget.email),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      "Phone: "),
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      widget.phone),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      "Issue: "),
                  Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black,
                      ),
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
