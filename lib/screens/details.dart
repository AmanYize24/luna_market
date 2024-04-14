import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/cloud_firestore_functions.dart';
import 'package:luna_market/widgets/box.dart';

class Details extends StatefulWidget {
  final String imgUrl;
  final String name;
  final String price;
  final String description;
  const Details(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price,
      required this.description});

  @override
  State<Details> createState() => _DetailsState();
}

bool loading = false;

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Image(
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.imgUrl)),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w700),
                widget.name),
          ),
          box(0, 10),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
                style: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                'Price: ${widget.price}'),
          ),
          box(0, 10),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w700),
                'Description'),
          ),
          box(0, 10),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
                style: GoogleFonts.inter(
                  fontSize: 17,
                ),
                widget.description),
          ),
          box(0, 50),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 350,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  await addToCart(
                      context: context,
                      email: "${FirebaseAuth.instance.currentUser!.email}",
                      cartData: {
                        'name': widget.name,
                        'img': widget.imgUrl,
                        'price': widget.price,
                        'description': widget.description
                      });
                  setState(() {
                    loading = false;
                  });
                },
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        'Add to cart'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
