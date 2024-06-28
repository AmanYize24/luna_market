import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/functions/support_functions.dart';
import 'package:luna_market/widgets/box.dart';

class SupportLogin extends StatefulWidget {
  const SupportLogin({super.key});

  @override
  State<SupportLogin> createState() => _SupportLoginState();
}

class _SupportLoginState extends State<SupportLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Support Login")),
        actions: [box(25, 0)],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2023/12/07/10/52/snow-8435305_1280.jpg"))),
        child: ListView(
          children: [
            box(0, 150),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 325,
                height: 50,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
                child: TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      hintText: "email",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            box(0, 25),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 325,
                height: 45,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            box(0, 100),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 325,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        await getSupport(
                          email: email.text,
                          password: password.text,
                          context: context,
                        );
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
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              "Login"))),
            ),
          ],
        ),
      ),
    );
  }
}
