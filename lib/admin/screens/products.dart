import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
            future: widget.products(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: widget.productList.length,
                    itemBuilder: (context, index) => Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: const Column(
                            children: [
                              SizedBox(width: 100, height: 100, child: Text(''))
                            ],
                          ),
                        ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text("Error");
              }
            }),
      ),
    );
  }
}
