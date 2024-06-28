import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/add_checkout.dart';
import 'package:luna_market/functions/cloud_firestore_functions.dart';
import 'package:luna_market/functions/pickfile.dart';
import 'package:provider/provider.dart';

import '../widgets/box.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  BuildContext getContext() {
    return context;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String name = '';
  String location = '';
  String email = "${FirebaseAuth.instance.currentUser!.email}";
  String phoneNumber = '';
  String paymentMethod = '';
  dynamic proofImgUrl;
  bool isWeb = kIsWeb;

  bool loading = false;

  Future<double> calculateCart() async {
    double total = 0;
    try {
      List newCart = await CartProvider().getCart(context);

      for (int i = 0; i < newCart.length; i++) {
        String val = newCart[i]['price'].split('E')[0];
        List newVal = val.split(',');
        String tVal = '';

        for (int i = 0; i < newVal.length; i++) {
          tVal = tVal + newVal[i];
        }
        total = total + double.parse(tVal);
      }
    } catch (e) {
      void showThis1() {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('error'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('cancel'))
                  ],
                ));
      }

      showThis1();
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://pixabay.com/get/gcdfd925cfc8b9f924dbd23e0ed514e7502342a195cd126bd20d1d20401880a8fde709e253111e00edaa0aa4bcdf1c4e5.jpg'))),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Text(
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white),
                'User information'),
            box(0, 10),
            Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
              child: ListView(
                children: [
                  box(0, 20),
                  Row(
                    children: [
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          'Name: '),
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 17),
                          name)
                    ],
                  ),
                  box(0, 10),
                  Row(
                    children: [
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          'Email: '),
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 17),
                          email)
                    ],
                  ),
                  box(0, 10),
                  Row(
                    children: [
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          'Location: '),
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 17),
                          location)
                    ],
                  ),
                  box(0, 10),
                  Row(
                    children: [
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 17),
                          'Phone: '),
                      Text(
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 17),
                          phoneNumber)
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 100,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            'Change user information'),
                        content: SizedBox(
                          width: 300,
                          height: 200,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 55,
                                child: TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Name',
                                      fillColor: Colors.white),
                                ),
                              ),
                              box(0, 10),
                              SizedBox(
                                height: 55,
                                child: TextField(
                                  controller: locationController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Location',
                                      fillColor: Colors.white),
                                ),
                              ),
                              box(0, 10),
                              SizedBox(
                                height: 55,
                                child: TextField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Phone',
                                      fillColor: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('cancel')),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  name = nameController.text;
                                  location = locationController.text;
                                  phoneNumber = phoneController.text;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('update'))
                        ],
                      ),
                    );
                  },
                  child: Text(
                      style: GoogleFonts.inter(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      'Change'),
                ),
              ),
            ),
            Text(
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white),
                'Payment Method'),
            box(0, 10),
            Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  child: DropdownMenu(
                    inputDecorationTheme: const InputDecorationTheme(
                        fillColor: Colors.white, iconColor: Colors.black),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'telebirr', label: 'Telebirr'),
                      DropdownMenuEntry(value: 'cbe', label: 'CBE')
                    ],
                    onSelected: (value) {
                      setState(() {
                        paymentMethod = '$value';
                      });
                    },
                  ),
                ),
                box(20, 0),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 200,
                      height: 65,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.5)),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                              width: 65,
                              height: 65,
                              child: isWeb
                                  ? (proofImgUrl == null
                                      ? const Icon(Icons.add_a_photo)
                                      : Image.memory(proofImgUrl!))
                                  : (proofImgUrl == null
                                      ? const Icon(Icons.add_a_photo)
                                      : Image.file(File(proofImgUrl)))),
                          TextButton(
                              onPressed: () async {
                                proofImgUrl = await imgPath(context: context);

                                setState(() {
                                  proofImgUrl;
                                });
                              },
                              child: Text(
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  'payment proof')),
                        ],
                      )),
                )
              ],
            ),
            box(0, 10),
            Text(
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                'Order Summary'),
            box(0, 10),
            Container(
              width: double.infinity,
              height: 230,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
              child: Consumer<CartProvider>(
                builder: (context, value, child) => ListView(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: FutureBuilder(
                            future: value.getCart(context),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) => Container(
                                          width: double.infinity,
                                          height: 50,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Column(
                                            children: [
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                      style: GoogleFonts.inter(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      "${snapshot.data![index]['name']}")),
                                              box(20, 0),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                      style: GoogleFonts.inter(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      "${snapshot.data![index]['price']}")),
                                            ],
                                          ),
                                        ));
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return const Text('error');
                              }
                            }),
                      ),
                    ),
                    FutureBuilder(
                        future: calculateCart(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ListView(
                                children: [
                                  box(0, 10),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          style: GoogleFonts.inter(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          "TOTAL")),
                                  box(20, 5),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          "${snapshot.data}ETB")),
                                ],
                              ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Text('error');
                          }
                        }),
                  ],
                ),
              ),
            ),
            box(0, 10),
            SizedBox(
              width: 300,
              height: 50,
              child: Consumer<CartProvider>(builder: (context, value, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await addToCheckout(
                        name: name,
                        proofImg: await pickFile(
                            file: proofImgUrl, context: getContext()),
                        email: email,
                        phone: phoneNumber,
                        paymentMethod: paymentMethod,
                        cartData: await value.getCart(getContext()),
                        total: '${await calculateCart()}',
                        location: location,
                        context: getContext());
                    setState(() {
                      loading = false;
                    });
                  },
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          'Continue'),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
