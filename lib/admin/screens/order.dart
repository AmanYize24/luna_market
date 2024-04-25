import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/admin/admin_firestore.dart';
import 'package:luna_market/admin/screens/order_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          child: ListView(children: [
            SizedBox(
              width: double.infinity,
              height: 600,
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                          cart: snapshot.data![index]['cart'],
                                          name: snapshot.data![index]['name'],
                                          paymentProof: snapshot.data![index]
                                              ["payment proof"],
                                          total: snapshot.data![index]['total'],
                                          paymentMethod: snapshot.data![index]
                                              ['payment method'],
                                          email: snapshot.data![index]['email'],
                                          phoneNumber: snapshot.data![index]
                                              ['phone'])));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors: [Colors.teal, Colors.black]),
                                      border: Border.all(color: Colors.black)),
                                  width: 350,
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        'from: ${snapshot.data![index]["email"]}'),
                                  ),
                                ),
                              ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text("Error");
                    }
                  }),
            ),
          ])),
    );
  }
}
