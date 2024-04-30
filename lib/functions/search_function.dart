// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';

Future<List> getItems({required String name}) async {
  final storageRef = FirebaseStorage.instance.ref();

  var listRef = storageRef.child(name);
  final listOfProducts = [];
  final items = await listRef.listAll().then((value) => value.items);
  final List listPath = [];
  for (int i = 0; i < items.length; i++) {
    listPath.add([items[i].fullPath, items[i].fullPath]);
  }
  for (int i = 0; i < listPath.length; i++) {
    final itemImgUrl = await storageRef.child(listPath[i][0]).getDownloadURL();

    final itemPath = storageRef.child(listPath[i][1]);
    final itemName = itemPath.fullPath.split('&')[0].split('/')[1];
    final itemPrice = itemPath.fullPath.split('&')[1];
    final itemDescription = itemPath.fullPath.split('&')[2];
    listOfProducts.add({
      "url": itemImgUrl,
      "name": itemName,
      "price": itemPrice,
      "description": itemDescription
    });
  }

  return listOfProducts;
}

List possibleItem = [];
Future<List> searchItems({required String product}) async {
  possibleItem = [];
  Future<List> featured = getItems(name: "Featured");
  Future<List> newProducts = getItems(name: "New Products");
  Future<List> electronics = getItems(name: "Electronics");
  Future<List> clothing = getItems(name: "Clothing");
  Future<List> furniture = getItems(name: "Furniture");
  Future<List> cars = getItems(name: "Cars");
  Future<List> house = getItems(name: "House");
  List allProducts = await featured +
      await newProducts +
      await electronics +
      await clothing +
      await furniture +
      await cars +
      await house;

  for (int i = 0; i < allProducts.length; i++) {
    String first = allProducts[i]["name"].split(" ")[0].toLowerCase();
    String char = first[0] + first[1];
    String char2 = product[0].toLowerCase() + product[1].toLowerCase();
    if (char == char2) {
      possibleItem.add(allProducts[i]);
    }
  }
  return possibleItem;
}
