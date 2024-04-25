import 'package:flutter/material.dart';
import 'package:luna_market/functions/firebase_storage_functions.dart';

class Category extends StatefulWidget {
  final List categoryList;
  final String name;
  final Future waitFor;
  const Category(
      {super.key,
      required this.categoryList,
      required this.name,
      required this.waitFor});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    electronicsImg = [];
    clothingImg = [];
    furnitureImg = [];
    carsImg = [];
    houseImg = [];
    newProductsImg = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
            onPressed: () {
              newProductsImg = [];

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
          future: widget.waitFor,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: ((context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: snapshot.data![index],
                        ))),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Text('error');
            }
          }),
    );
  }
}
