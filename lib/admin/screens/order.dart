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
  bool loading = false;
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
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/11/23/14/54/snow-1853352_1280.jpg'))),
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
                          itemBuilder: (context, index) => Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => OrderDetails(
                                                cart: snapshot.data![index]
                                                    ['cart'],
                                                name: snapshot.data![index]
                                                    ['name'],
                                                paymentProof:
                                                    snapshot.data![index]
                                                        ["payment proof"],
                                                total: snapshot.data![index]
                                                    ['total'],
                                                paymentMethod:
                                                    snapshot.data![index]
                                                        ['payment method'],
                                                email: snapshot.data![index]
                                                    ['email'],
                                                phoneNumber: snapshot
                                                    .data![index]['phone'])));
                                  },
                                  /** Orders */ child: Container(
                                    width: 390,
                                    height: 60,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color.fromRGBO(255, 255, 255, 0.5),
                                          Color.fromRGBO(255, 255, 255, 0.5)
                                        ]),
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                                'from: ${snapshot.data![index]["email"]}'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  await deleteOrder(
                                                      email:
                                                          "${snapshot.data![index]["email"]}",
                                                      context: context);
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                },
                                                icon: loading
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : const Icon(
                                                        size: 30,
                                                        color:
                                                            Colors.pinkAccent,
                                                        Icons.delete),
                                              )),
                                        ),
                                      ],
                                    ),
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
