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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Requests"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2021/03/11/02/57/mountain-6086083_1280.jpg'),
                fit: BoxFit.cover)),
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
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.5)),
                                    width: double.infinity,
                                    height: 110,
                                    child: ListView(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                            child: Center(
                                              child: Text(
                                                  style: GoogleFonts.inter(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  "${snapshot.data![index]["email"]}"),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: IconButton(
                                              onPressed: () async {
                                                setState(() {
                                                  loading = true;
                                                });
                                                await deleteUserRequest(
                                                    email: snapshot.data![index]
                                                        ["email"],
                                                    context: context);
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
                                                      Icons.delete,
                                                      color: Colors.pinkAccent,
                                                    )),
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
