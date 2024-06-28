import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luna_market/screens/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/home_functions.dart';
import 'package:luna_market/provider/home_provider.dart';
import 'package:luna_market/screens/cart.dart';
import 'package:luna_market/screens/customer_service.dart';
import 'package:luna_market/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luna_market/screens/search.dart';
import 'package:luna_market/widgets/box.dart';
import 'package:luna_market/widgets/profile_icon.dart';
import 'package:provider/provider.dart';
import '../auth/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../functions/firebase_storage_functions.dart';
import 'package:universal_platform/universal_platform.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  List<String> myStringList = [];
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    newProductsImg = [];
    electronicsImg = [];
    houseImg = [];
    featuredImg = [];
    clothingImg = [];
    furnitureImg = [];
    carsImg = [];
    double caroselHeight = 0;
    try {
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
        caroselHeight = 220;
      } else {
        caroselHeight = 310;
      }
    } catch (e) {
      caroselHeight = 310;
    }
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Cart()));
                },
                icon: const Icon(Icons.shopping_cart)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Search()));
                },
                icon: const Icon(Icons.search))
          ],
          title: Center(
              child: Text(
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                  "Home")),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.greenAccent,
              Color.fromARGB(255, 225, 149, 255)
            ])),
          ),
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
        ),
        drawer: Opacity(
          opacity: 0.9,
          child: Drawer(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.greenAccent.withOpacity(0.5),
                Colors.greenAccent.withOpacity(0.1)
              ])),
              child: ListView(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.5)),
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      },
                      child: Column(
                        children: [
                          Consumer<HomeProvider>(
                              builder: (context, value, child) =>
                                  value.profileImg == ''
                                      ? profileIcon()
                                      : Text(value.profileImg)),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  Colors.transparent,
                                  Colors.white
                                ])),
                                child: Center(
                                  child: Text(
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      FirebaseAuth.instance.currentUser == null
                                          ? 'unknown'
                                          : FirebaseAuth
                                              .instance.currentUser!.displayName
                                              .toString()),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  box(0, 20),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Cart()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 60, 0, 72),
                              Colors.transparent
                            ])),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              Text(
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  'Cart'),
                            ],
                          ),
                        ),
                      )),
                  box(0, 20),
                  GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CustomerService()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 60, 0, 72),
                              Colors.transparent
                            ])),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              Text(
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  'Customer Service'),
                            ],
                          ),
                        ),
                      )),
                  box(0, 20),
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        await signOut(context);
                        setState(() {
                          loading = false;
                        });
                        setState(() {
                          signOutFromHome(context);
                        });
                      },
                      child: loading
                          ? const CircularProgressIndicator()
                          : Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 60, 0, 72),
                                    Colors.transparent
                                  ])),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    Text(
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                        'Logout'),
                                  ],
                                ),
                              ),
                            )),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2017/08/02/14/26/winter-landscape-2571788_1280.jpg'))),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              box(0, 20),
              Text(
                  style: GoogleFonts.inter(
                      fontSize: 17, fontWeight: FontWeight.bold),
                  'Featured Products'),
              box(0, 20),
              FutureBuilder(
                  future: showFeatured(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return const Text('Active');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SizedBox(
                          width: 300,
                          height: 300,
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.greenAccent.withOpacity(0.2),
                          Colors.purpleAccent.withOpacity(0.05)
                        ])),
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.center,
                          child: CarouselSlider(
                              options: CarouselOptions(
                                height: caroselHeight,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                autoPlayInterval: const Duration(seconds: 5),
                              ),
                              items: featuredImg.map((i) => i).toList()),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              box(0, 10),
              Text(
                  style: GoogleFonts.inter(
                      fontSize: 17, fontWeight: FontWeight.bold),
                  'Catagories'),
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      box(15, 0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Category(
                                    categoryList: electronicsImg,
                                    name: 'Electronics',
                                    waitFor: showElectronics(context: context),
                                  )));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.pinkAccent,
                          maxRadius: 30,
                          child: Icon(
                              size: 30,
                              color: Colors.white,
                              Icons.electrical_services),
                        ),
                      ),
                      box(10, 0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Category(
                                    categoryList: clothingImg,
                                    name: 'Clothing',
                                    waitFor: showClothing(context: context),
                                  )));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          maxRadius: 30,
                          child: Icon(
                              size: 30, color: Colors.white, Icons.checkroom),
                        ),
                      ),
                      box(10, 0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Category(
                                    categoryList: furnitureImg,
                                    name: 'Furniture',
                                    waitFor: showFurniture(context: context),
                                  )));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.purpleAccent,
                          maxRadius: 30,
                          child:
                              Icon(size: 30, color: Colors.white, Icons.chair),
                        ),
                      ),
                      box(10, 0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Category(
                                    categoryList: carsImg,
                                    name: 'Cars',
                                    waitFor: showCars(context: context),
                                  )));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          maxRadius: 30,
                          child: Icon(
                              size: 30,
                              color: Colors.white,
                              Icons.directions_car),
                        ),
                      ),
                      box(10, 0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Category(
                                    categoryList: houseImg,
                                    name: 'House',
                                    waitFor: showHouse(context: context),
                                  )));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          maxRadius: 30,
                          child:
                              Icon(size: 30, color: Colors.white, Icons.house),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                          style: GoogleFonts.inter(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          'New Products'),
                    ),
                    box(100, 0),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Category(
                                categoryList: newProductsImg,
                                name: 'New Products',
                                waitFor: showViewProducts(context: context),
                              ),
                            ),
                          );
                        },
                        child: Text(
                            style: GoogleFonts.inter(
                                fontSize: 17, fontWeight: FontWeight.bold),
                            'View more'),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: showNewProducts(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          width: double.infinity,
                          height: 260,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 180,
                                height: 120,
                                padding: const EdgeInsets.all(10),
                                child: snapshot.data![index],
                              );
                            },
                          ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text('error');
                    }
                  }),
              box(0, 20),
            ],
          ),
        ));
  }
}
