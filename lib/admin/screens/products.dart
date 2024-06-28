import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/admin/admin_storage.dart';
import 'package:luna_market/admin/screens/add_products.dart';
import 'package:luna_market/widgets/box.dart';

class Products extends StatefulWidget {
  final String title;
  final dynamic products;
  final List productList;
  const Products(
      {super.key,
      required this.title,
      required this.products,
      required this.productList});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_1280.jpg'))),
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 620,
                child: FutureBuilder(
                    future: getItems(name: widget.title),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color.fromRGBO(255, 255, 255, 0.8),
                                          Color.fromRGBO(255, 255, 255, 0.3)
                                        ]),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            width: 360,
                                            height: 150,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 5),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: SizedBox(
                                                      width: 150,
                                                      height: 150,
                                                      child: Image(
                                                        fit: BoxFit.contain,
                                                        image: NetworkImage(
                                                            '${snapshot.data![index]["url"]}'),
                                                      )),
                                                ),
                                                box(10, 0),
                                                Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: SizedBox(
                                                          width: 200,
                                                          height: 25,
                                                          child: Text(
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              '${snapshot.data![index]["name"]}')),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: SizedBox(
                                                          width: 200,
                                                          height: 25,
                                                          child: Text(
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              '${snapshot.data![index]["price"]}')),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: SizedBox(
                                                          width: 220,
                                                          height: 50,
                                                          child: Text(
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11,
                                                              ),
                                                              '${snapshot.data![index]["description"]}')),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 50,
                                            height: 130,
                                            child: Center(
                                              child: IconButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    final List arr = snapshot
                                                        .data![index]["url"]
                                                        .split(".");
                                                    final String ext =
                                                        arr[arr.length - 1]
                                                            .split("?")[0];
                                                    await deleteProduct(
                                                        context: context,
                                                        refName: widget.title,
                                                        name: snapshot
                                                                .data![index]
                                                            ["name"],
                                                        price: snapshot
                                                                .data![index]
                                                            ["price"],
                                                        ext: ext,
                                                        description: snapshot
                                                                .data![index]
                                                            ["description"]);
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
                                                          Icons.delete)),
                                            ),
                                          ),
                                        )
                                      ],
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
              box(0, 25),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AddProducts(ref: widget.title)));
                      },
                      child: Text(
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                          "Add Product")),
                ),
              )
            ],
          ),
        ));
  }
}
