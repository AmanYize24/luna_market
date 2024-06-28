import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/customer_service_functions.dart';
import 'package:luna_market/widgets/box.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController issue = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Customer Service"),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2022/12/10/11/08/trees-7646958_960_720.jpg'))),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView(
              children: [
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Request Form"),
                          content: SizedBox(
                            width: 400,
                            height: 700,
                            child: ListView(
                              children: [
                                Text(
                                    style:
                                        GoogleFonts.inter(color: Colors.grey),
                                    "Name"),
                                box(0, 5),
                                SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: TextField(
                                    controller: name,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                box(0, 5),
                                Text(
                                    style:
                                        GoogleFonts.inter(color: Colors.grey),
                                    "Email"),
                                box(0, 5),
                                SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: TextField(
                                    controller: email,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                box(0, 5),
                                Text(
                                    style:
                                        GoogleFonts.inter(color: Colors.grey),
                                    "Phone"),
                                box(0, 5),
                                SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: TextField(
                                    controller: phone,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                box(0, 5),
                                Text(
                                    style:
                                        GoogleFonts.inter(color: Colors.grey),
                                    "Describe your issue"),
                                box(0, 5),
                                SizedBox(
                                  width: 250,
                                  height: 150,
                                  child: TextField(
                                    controller: issue,
                                    maxLines: 20,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  await addAnIssue(
                                      name: name.text,
                                      email: email.text,
                                      phone: phone.text,
                                      context: context,
                                      issue: issue.text);

                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child: loading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text("Submit"))
                          ],
                        ),
                      );
                    },
                    child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                            child: Text("Request Customer Service"))))
              ],
            )));
  }
}
