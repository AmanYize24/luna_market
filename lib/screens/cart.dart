import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/cloud_firestore_functions.dart';
import 'package:luna_market/screens/checkout.dart';
import 'package:luna_market/widgets/box.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cart'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Consumer<CartProvider>(builder: (context, value, child) {
          return ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 600,
                child: FutureBuilder(
                    future: value.getCart(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        return const Text('active');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return snapshot.data!.isEmpty
                            ? ListView(children: [
                                box(0, 30),
                                const Text('Cart is empty')
                              ])
                            : ListView.builder(
                                padding: const EdgeInsets.all(15),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      width: double.infinity,
                                      height: 150,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 150,
                                            height: 250,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image(
                                                  width: 175,
                                                  height: 300,
                                                  fit: BoxFit.contain,
                                                  image: NetworkImage(snapshot
                                                      .data![index]['img'])),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 210,
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                  Colors.greenAccent,
                                                  Colors.white
                                                ])),
                                            child: ListView(
                                              children: [
                                                box(0, 5),
                                                SizedBox(
                                                  height: 20,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                        "${snapshot.data![index]['name']}"),
                                                  ),
                                                ),
                                                box(0, 5),
                                                SizedBox(
                                                  height: 20,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        style:
                                                            GoogleFonts.inter(
                                                                color: Colors
                                                                    .grey),
                                                        "${snapshot.data![index]['price']}"),
                                                  ),
                                                ),
                                                box(0, 5),
                                                SizedBox(
                                                  height: 30,
                                                  child: ListView(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            style: GoogleFonts
                                                                .inter(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10),
                                                            "${snapshot.data![index]['description']}"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 50,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            loading = true;
                                                          });

                                                          await removeFromCart(
                                                              context: context,
                                                              obj: {
                                                                'description':
                                                                    snapshot.data![
                                                                            index]
                                                                        [
                                                                        'description'],
                                                                'img': snapshot
                                                                        .data![
                                                                    index]['img'],
                                                                'name': snapshot
                                                                        .data![
                                                                    index]['name'],
                                                                'price': snapshot
                                                                        .data![
                                                                    index]['price']
                                                              });
                                                          setState(() {
                                                            loading = false;
                                                          });
                                                        },
                                                        icon: loading
                                                            ? const CircularProgressIndicator()
                                                            : const Icon(
                                                                Icons.delete,
                                                                color: Colors
                                                                    .pinkAccent,
                                                              )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                      } else {
                        return const Text('error');
                      }
                    }),
              ),
              box(0, 50),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Checkout()));
                    },
                    child: Text(
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        'Checkout'),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
