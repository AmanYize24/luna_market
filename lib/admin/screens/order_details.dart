import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/admin/screens/show_proof.dart';

class OrderDetails extends StatefulWidget {
  final List cart;
  final String name;
  final String total;
  final String phoneNumber;
  final String paymentProof;
  final String email;
  final String paymentMethod;
  const OrderDetails(
      {super.key,
      required this.cart,
      required this.name,
      required this.paymentProof,
      required this.total,
      required this.email,
      required this.phoneNumber,
      required this.paymentMethod});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2018/02/18/21/30/coffee-3163596_960_720.jpg'))),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0.2)
                  ]),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        "Name: "),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          style: GoogleFonts.inter(fontSize: 17), widget.name)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0.2)
                  ]),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        "Email: "),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          style: GoogleFonts.inter(fontSize: 17),
                          widget.email)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0.2)
                  ]),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        "Phone: "),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          style: GoogleFonts.inter(fontSize: 17),
                          widget.phoneNumber)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0.2)
                  ]),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.cart.length,
                  itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        width: 150,
                        height: 150,
                        child: ListView(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.cart[index]['img']),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                  style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                  "${widget.cart[index]['name']}"),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                  style: GoogleFonts.inter(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                  "${widget.cart[index]['price']}"),
                            )
                          ],
                        ),
                      )),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0.2)
                  ]),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        "Total: "),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          style: GoogleFonts.inter(fontSize: 17),
                          widget.total)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0.2)
                  ]),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        "Payment Method: "),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          style: GoogleFonts.inter(fontSize: 17),
                          widget.paymentMethod)),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 0.8),
                    Color.fromRGBO(255, 255, 255, 0.2)
                  ]),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: GoogleFonts.inter(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        "payment proof: "),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Proof(proofImg: widget.paymentProof)));
                        },
                        child: SizedBox(
                            width: 60,
                            height: 60,
                            child: Image(
                                fit: BoxFit.contain,
                                image: NetworkImage(widget.paymentProof))),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
