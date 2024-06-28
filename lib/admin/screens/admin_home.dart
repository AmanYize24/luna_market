import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luna_market/admin/screens/order.dart';
import 'package:luna_market/admin/screens/products.dart';
import 'package:luna_market/auth/auth.dart';
import 'package:luna_market/functions/firebase_storage_functions.dart';
import 'package:luna_market/screens/wrapper.dart';
import 'package:luna_market/widgets/admin_dashboard_btn.dart';
import '../admin_firestore.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Home',
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await signOut(context);
                if (FirebaseAuth.instance.currentUser != null) {
                } else {
                  void goTo() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Wrapper()));
                  }

                  goTo();
                }
              },
              child: const Text('Logout')),
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2016/10/21/09/25/rocks-1757593_1280.jpg"))),
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            adminDashboardBtn(
                                btnName: 'Orders',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Orders()));
                                }),
                            adminDashboardBtn(
                                btnName: 'Featured Products',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Products(
                                            title: "Featured",
                                            productList: featuredImg,
                                            products: () async {
                                              await showFeatured(
                                                  context: context);
                                            },
                                          )));
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            adminDashboardBtn(
                                btnName: 'New Products',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Products(
                                            title: "New Products",
                                            productList: featuredImg,
                                            products: () async {
                                              await showFeatured(
                                                  context: context);
                                            },
                                          )));
                                }),
                            adminDashboardBtn(
                                btnName: 'Electronics',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Products(
                                            title: "Electronics",
                                            productList: featuredImg,
                                            products: () async {
                                              await showFeatured(
                                                  context: context);
                                            },
                                          )));
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            adminDashboardBtn(
                                btnName: 'Clothing',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Products(
                                            title: "Clothing",
                                            productList: featuredImg,
                                            products: () async {
                                              await showFeatured(
                                                  context: context);
                                            },
                                          )));
                                }),
                            adminDashboardBtn(
                                btnName: 'Furniture',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Products(
                                            title: "Furniture",
                                            productList: featuredImg,
                                            products: () async {
                                              await showFeatured(
                                                  context: context);
                                            },
                                          )));
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            adminDashboardBtn(
                                btnName: 'Cars',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Products(
                                            title: "Cars",
                                            productList: featuredImg,
                                            products: () async {
                                              await showFeatured(
                                                  context: context);
                                            },
                                          )));
                                }),
                            adminDashboardBtn(
                                btnName: 'House',
                                onPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Products(
                                            title: "House",
                                            productList: featuredImg,
                                            products: () async {
                                              await showFeatured(
                                                  context: context);
                                            },
                                          )));
                                }),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text('Error');
                }
              })),
    );
  }
}
