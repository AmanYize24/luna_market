import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/support_functions.dart';
import 'package:luna_market/screens/user_request_details.dart';

class UserRequests extends StatefulWidget {
  const UserRequests({super.key});

  @override
  State<UserRequests> createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Requests"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            FutureBuilder(
              future: getUserRequests(context: context),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: 400,
                    height: 600,
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length - 1,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserRequestDetails(
                                        name: snapshot.data![index]["name"],
                                        email: snapshot.data![index]["email"],
                                        phone: snapshot.data![index]["phone"],
                                        issue: snapshot.data![index]
                                            ["issue"])));
                              },
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    width: double.infinity,
                                    height: 90,
                                    child: ListView(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                              style: GoogleFonts.inter(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                              "${snapshot.data![index]["email"]}"),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.delete)),
                                        )
                                      ],
                                    )),
                              ),
                            )),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text("Unknown Error"),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
