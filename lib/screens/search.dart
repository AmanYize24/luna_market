import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/search_function.dart';
import 'package:luna_market/screens/details.dart';
import 'package:luna_market/widgets/box.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        title: const Text('Search'),
        actions: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300,
              height: 40,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await searchItems(product: searchController.text);
                    setState(() {
                      possibleItem;
                      loading = false;
                    });
                  },
                  icon: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(Icons.search_outlined)),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2023/04/14/23/06/ai-generated-7926621_1280.jpg'))),
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
            itemCount: possibleItem.length,
            itemBuilder: ((context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Details(
                            imgUrl: possibleItem[index]['url'],
                            name: possibleItem[index]['name'],
                            price: possibleItem[index]['price'],
                            description: possibleItem[index]['description'])));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    width: double.infinity,
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 150,
                            height: 100,
                            child: Image(
                                fit: BoxFit.contain,
                                image:
                                    NetworkImage(possibleItem[index]["url"])),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 150,
                          padding: const EdgeInsets.all(10),
                          child: ListView(
                            children: [
                              box(0, 10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    "${possibleItem[index]["name"]}"),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey),
                                    "${possibleItem[index]["price"]}"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
