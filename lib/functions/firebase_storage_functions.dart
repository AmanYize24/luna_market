import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/screens/details.dart';
import 'package:luna_market/widgets/box.dart';
import 'package:luna_market/widgets/card.dart';
import 'package:universal_platform/universal_platform.dart';

final storageRef = FirebaseStorage.instance.ref();
final featuredRef = storageRef.child('Featured');
final electronicsRef = storageRef.child('Electronics');
final clothingRef = storageRef.child('Clothing');
final furnitureRef = storageRef.child('Furniture');
final carsRef = storageRef.child('Cars');
final houseRef = storageRef.child('House');
final newProductsRef = storageRef.child('New Products');

List<Widget> featuredImg = [];
List<Widget> electronicsImg = [];
List<Widget> clothingImg = [];
List<Widget> furnitureImg = [];
List<Widget> carsImg = [];
List<Widget> houseImg = [];
List<Widget> newProductsImg = [];
double imgHeight = 0;
Future<List> showFeatured({required context}) async {
  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    imgHeight = 180;
  } else {
    imgHeight = 270;
  }
  featuredImg = [];
  var featuredList = await featuredRef.listAll().then((value) => value.items);
  var featuredListPath = [];
  for (int i = 0; i < featuredList.length; i++) {
    featuredListPath.add([featuredList[i].fullPath, featuredList[i].fullPath]);
  }
  for (int i = 0; i < featuredListPath.length; i++) {
    final featuredImgUrl =
        await storageRef.child(featuredListPath[i][0]).getDownloadURL();
    final featuredPath = storageRef.child(featuredListPath[i][1]);
    final featuredName = featuredPath.fullPath.split('&')[0].split('/')[1];
    final featuredPrice = featuredPath.fullPath.split('&')[1];
    final featuredDescription = featuredPath.fullPath.split('&')[2];
    featuredImg.add(GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(
                  imgUrl: featuredImgUrl,
                  name: featuredName,
                  price: featuredPrice,
                  description: featuredDescription,
                )));
      },
      child: Align(
        alignment: Alignment.center,
        child: ListView(
          children: [
            Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                      width: double.infinity,
                      height: imgHeight,
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(featuredImgUrl)),
                )),
            box(0, 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                  style: GoogleFonts.inter(
                      fontSize: 17, fontWeight: FontWeight.w800),
                  featuredName),
            ),
            box(0, 20),
          ],
        ),
      ),
    ));
  }
  return featuredImg;
}

Future<List> showElectronics({required context}) async {
  var electronicList =
      await electronicsRef.listAll().then((value) => value.items);
  var electronicListPath = [];
  for (int i = 0; i < electronicList.length; i++) {
    electronicListPath
        .add([electronicList[i].fullPath, electronicList[i].fullPath]);
  }
  for (int i = 0; i < electronicListPath.length; i++) {
    final featuredImgUrl =
        await storageRef.child(electronicListPath[i][0]).getDownloadURL();
    final electronicsPath = storageRef.child(electronicListPath[i][1]);
    final electronicsName =
        electronicsPath.fullPath.split('&')[0].split('/')[1];
    final electronicsPrice = electronicsPath.fullPath.split('&')[1];
    final electronicsDescription = electronicsPath.fullPath.split('&')[2];
    electronicsImg.add(GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(
                  imgUrl: featuredImgUrl,
                  name: electronicsName,
                  price: electronicsPrice,
                  description: electronicsDescription,
                )));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 5, 31, 39),
            Color.fromARGB(255, 5, 33, 22)
          ]),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image(
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      image: NetworkImage(featuredImgUrl)),
                )),
            box(0, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          electronicsName),
                    ),
                    box(0, 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          electronicsPrice),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
  return electronicsImg;
}

Future<List> showClothing({required context}) async {
  var clothingList = await clothingRef.listAll().then((value) => value.items);
  var clothingListPath = [];
  for (int i = 0; i < clothingList.length; i++) {
    clothingListPath.add([clothingList[i].fullPath, clothingList[i].fullPath]);
  }
  for (int i = 0; i < clothingListPath.length; i++) {
    final clothingImgUrl =
        await storageRef.child(clothingListPath[i][0]).getDownloadURL();
    final clothingPath = storageRef.child(clothingListPath[i][1]);
    final clothingName = clothingPath.fullPath.split('&')[0].split('/')[1];
    final clothingPrice = clothingPath.fullPath.split('&')[1];
    final clothingDescription = clothingPath.fullPath.split('&')[2];
    clothingImg.add(GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(
                  imgUrl: clothingImgUrl,
                  name: clothingName,
                  price: clothingPrice,
                  description: clothingDescription,
                )));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 5, 31, 39),
            Color.fromARGB(255, 5, 33, 22)
          ]),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image(
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      image: NetworkImage(clothingImgUrl)),
                )),
            box(0, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          clothingName),
                    ),
                    box(0, 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          clothingPrice),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  return clothingImg;
}

Future<List> showFurniture({required context}) async {
  var furnitureList = await furnitureRef.listAll().then((value) => value.items);
  var furnitureListPath = [];
  for (int i = 0; i < furnitureList.length; i++) {
    furnitureListPath
        .add([furnitureList[i].fullPath, furnitureList[i].fullPath]);
  }
  for (int i = 0; i < furnitureListPath.length; i++) {
    final furnitureImgUrl =
        await storageRef.child(furnitureListPath[i][0]).getDownloadURL();
    final furniturePath = storageRef.child(furnitureListPath[i][1]);
    final furnitureName = furniturePath.fullPath.split('&')[0].split('/')[1];
    final furniturePrice = furniturePath.fullPath.split('&')[1];
    final furnitureDescription = furniturePath.fullPath.split('&')[2];
    furnitureImg.add(GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(
                  imgUrl: furnitureImgUrl,
                  name: furnitureName,
                  price: furniturePrice,
                  description: furnitureDescription,
                )));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 5, 31, 39),
            Color.fromARGB(255, 5, 33, 22)
          ]),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image(
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      image: NetworkImage(furnitureImgUrl)),
                )),
            box(0, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          furnitureName),
                    ),
                    box(0, 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          furniturePrice),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  return furnitureImg;
}

Future<List> showCars({required context}) async {
  var carsList = await carsRef.listAll().then((value) => value.items);
  var carsListPath = [];
  for (int i = 0; i < carsList.length; i++) {
    carsListPath.add([carsList[i].fullPath, carsList[i].fullPath]);
  }
  for (int i = 0; i < carsListPath.length; i++) {
    final carsImgUrl =
        await storageRef.child(carsListPath[i][0]).getDownloadURL();
    final carsPath = storageRef.child(carsListPath[i][1]);
    final carsName = carsPath.fullPath.split('&')[0].split('/')[1];
    final carsPrice = carsPath.fullPath.split('&')[1];
    final carsDescription = carsPath.fullPath.split('&')[2];
    carsImg.add(GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(
                  imgUrl: carsImgUrl,
                  name: carsName,
                  price: carsPrice,
                  description: carsDescription,
                )));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 5, 31, 39),
            Color.fromARGB(255, 5, 33, 22)
          ]),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image(
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      image: NetworkImage(carsImgUrl)),
                )),
            box(0, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          carsName),
                    ),
                    box(0, 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          carsPrice),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  return carsImg;
}

Future<List> showHouse({required context}) async {
  var houseList = await houseRef.listAll().then((value) => value.items);
  var houseListPath = [];
  for (int i = 0; i < houseList.length; i++) {
    houseListPath.add([houseList[i].fullPath, houseList[i].fullPath]);
  }
  for (int i = 0; i < houseListPath.length; i++) {
    final houseImgUrl =
        await storageRef.child(houseListPath[i][0]).getDownloadURL();
    final housePath = storageRef.child(houseListPath[i][1]);
    final houseName = housePath.fullPath.split('&')[0].split('/')[1];
    final housePrice = housePath.fullPath.split('&')[1];
    final houseDescription = housePath.fullPath.split('&')[2];
    houseImg.add(GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(
                  imgUrl: houseImgUrl,
                  name: houseName,
                  price: housePrice,
                  description: houseDescription,
                )));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 5, 31, 39),
            Color.fromARGB(255, 5, 33, 22)
          ]),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image(
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      image: NetworkImage(houseImgUrl)),
                )),
            box(0, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          houseName),
                    ),
                    box(0, 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          housePrice),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  return houseImg;
}

Future<List> showNewProducts({required context}) async {
  newProductsImg = [];
  var newProductsList =
      await newProductsRef.listAll().then((value) => value.items);
  var newProductsListPath = [];
  for (int i = 0; i < newProductsList.length; i++) {
    newProductsListPath
        .add([newProductsList[i].fullPath, newProductsList[i].fullPath]);
  }
  for (int i = 0; i < newProductsListPath.length; i++) {
    final newProductsImgUrl =
        await storageRef.child(newProductsListPath[i][0]).getDownloadURL();
    final newProductsPath = storageRef.child(newProductsListPath[i][1]);
    final newProductsName =
        newProductsPath.fullPath.split('&')[0].split('/')[1];
    final newProductsPrice = newProductsPath.fullPath.split('&')[1];
    final newProductsDescription = newProductsPath.fullPath.split('&')[2];
    newProductsImg.add(GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Details(
                    imgUrl: newProductsImgUrl,
                    name: newProductsName,
                    price: newProductsPrice,
                    description: newProductsDescription,
                  )));
        },
        child: card(
            name: newProductsName,
            price: newProductsPrice,
            imgUrl: newProductsImgUrl,
            description: newProductsDescription)));
  }

  return newProductsImg;
}

Future<List> showViewProducts({required context}) async {
  newProductsImg = [];

  var newProductsList =
      await newProductsRef.listAll().then((value) => value.items);
  var newProductsListPath = [];
  for (int i = 0; i < newProductsList.length; i++) {
    newProductsListPath
        .add([newProductsList[i].fullPath, newProductsList[i].fullPath]);
  }
  for (int i = 0; i < newProductsListPath.length; i++) {
    final newProductsImgUrl =
        await storageRef.child(newProductsListPath[i][0]).getDownloadURL();
    final newProductsPath = storageRef.child(newProductsListPath[i][1]);
    final newProductsName =
        newProductsPath.fullPath.split('&')[0].split('/')[1];
    final newProductsPrice = newProductsPath.fullPath.split('&')[1];
    final newProductsDescription = newProductsPath.fullPath.split('&')[2];
    newProductsImg.add(GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(
                  imgUrl: newProductsImgUrl,
                  name: newProductsName,
                  price: newProductsPrice,
                  description: newProductsDescription,
                )));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 5, 31, 39),
            Color.fromARGB(255, 5, 33, 22)
          ]),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image(
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      image: NetworkImage(newProductsImgUrl)),
                )),
            box(0, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          newProductsName),
                    ),
                    box(0, 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          newProductsPrice),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  return newProductsImg;
}
