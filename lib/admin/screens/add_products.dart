import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/admin/admin_storage.dart';
import 'package:luna_market/widgets/box.dart';

class AddProducts extends StatefulWidget {
  final String ref;
  const AddProducts({super.key, required this.ref});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  dynamic imgPath;
  String name = "";
  String price = "";
  String description = "";
  bool chooseName = false;
  bool choosePrice = false;
  bool chooseDescription = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload To ${widget.ref}"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2022/01/16/20/38/coffee-6943139_1280.jpg'))),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              width: 300,
              height: 300,
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () async {
                    imgPath = await pickUploadFile();
                    setState(() {
                      imgPath;
                    });
                  },
                  icon: imgPath == null
                      ? const Icon(Icons.add_a_photo)
                      : (kIsWeb
                          ? (Image.memory(
                              imgPath,
                            ))
                          : Image.file(
                              fit: BoxFit.contain,
                              File(imgPath),
                            )),
                ),
              ),
            ),
            box(0, 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  "Enter Product Name"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 300,
                      child: chooseName
                          ? Text(
                              style: GoogleFonts.inter(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              name)
                          : TextField(
                              controller: nameController,
                              onChanged: (value) {
                                name = value;
                                setState(() {
                                  name;
                                });
                              },
                            ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (chooseName == false) {
                            setState(() {
                              chooseName = true;
                            });
                          } else if (chooseName == true) {
                            setState(() {
                              chooseName = false;
                            });
                          }
                        },
                        icon: chooseName
                            ? const Icon(Icons.arrow_back)
                            : const Icon(Icons.arrow_forward))
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  "Enter Product Price"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 300,
                      child: choosePrice
                          ? Text(
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                              price)
                          : TextField(
                              controller: priceController,
                              onChanged: (value) {
                                price = value;
                                setState(() {
                                  price;
                                });
                              },
                            ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (choosePrice == false) {
                            setState(() {
                              choosePrice = true;
                            });
                          } else if (choosePrice == true) {
                            setState(() {
                              choosePrice = false;
                            });
                          }
                        },
                        icon: choosePrice
                            ? const Icon(Icons.arrow_back)
                            : const Icon(Icons.arrow_forward))
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  "Enter Product Description"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 300,
                      child: chooseDescription
                          ? Text(
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              description)
                          : TextField(
                              controller: descriptionController,
                              maxLines: 20,
                              onChanged: (value) {
                                description = value;
                                setState(() {
                                  description;
                                });
                              },
                            ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (chooseDescription == false) {
                            setState(() {
                              chooseDescription = true;
                            });
                          } else if (chooseDescription == true) {
                            setState(() {
                              chooseDescription = false;
                            });
                          }
                        },
                        icon: chooseDescription
                            ? const Icon(Icons.arrow_back)
                            : const Icon(Icons.arrow_forward))
                  ],
                ),
              ),
            ),
            box(0, 25),
            Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                        ),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await uploadProduct(
                              filePath: imgPath,
                              ref: widget.ref,
                              name: name,
                              price: "${price}ETB",
                              ext: "png",
                              context: context,
                              description: description);
                          setState(() {
                            loading = false;
                          });
                        },
                        child: loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                "Upload"))))
          ],
        ),
      ),
    );
  }
}
