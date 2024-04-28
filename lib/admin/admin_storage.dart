import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> chooseFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);

    return file.path;
  } else {
    return "";
  }
}

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

Future<bool> deleteProduct(
    {required String refName,
    required String name,
    required String price,
    required String ext,
    required String description}) async {
  bool checkDelete = false;
  final storageRef = FirebaseStorage.instance.ref();
  try {
    final item = storageRef.child("$refName/$name&$price&$description&.$ext");

    print("item found at $item");
    await item.delete();
    checkDelete = true;
  } catch (e) {
    print(e);
    checkDelete = false;
  }
  return checkDelete;
}

Future<String> pickUploadFile() async {
  return " ";
}
