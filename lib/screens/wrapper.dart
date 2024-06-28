import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luna_market/admin/screens/admin_home.dart';
import 'package:luna_market/admin/screens/admin_login.dart';
import 'package:luna_market/screens/support_login.dart';
import 'package:luna_market/screens/verify.dart';
import '../screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/auth.dart';
import 'package:luna_market/widgets/box.dart';
import 'package:luna_market/widgets/wrapper_btn.dart';
import '../functions/wrapper_functions.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }

  int counter = 0;
  int support = 0;
  Widget wrap() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2022/01/25/12/53/tree-6966126_960_720.jpg'))),
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    counter += 1;
                  });
                  if (counter == 5) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AdminLogin()));
                    setState(() {
                      counter = 0;
                    });
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/luna-market-logo.jfif"),
                  ),
                ),
              ),
              box(0, 20),
              GestureDetector(
                onTap: () {
                  support += 1;
                  if (support == 7) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SupportLogin()));
                    support = 0;
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    style: GoogleFonts.notoSerifEthiopic(fontSize: 25),
                    "ሰላም",
                  ),
                ),
              ),
              box(0, 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  style: GoogleFonts.merienda(fontSize: 25),
                  "Welcome To Luna Market",
                ),
              ),
              box(0, 40),
              WrapperBtn(
                firstText: "Create Account",
                secondText: "መለያ መፍጠር",
                navigateTo: () {
                  goToSignUp(context);
                },
              ),
              box(0, 25),
              WrapperBtn(
                firstText: "Login",
                secondText: "ግባ",
                navigateTo: () {
                  goToSignIn(context);
                },
              ),
              box(0, 25),
              WrapperBtn(
                firstText: loading ? 'loading' : "Anonymous",
                secondText: "ስም-አልባ",
                navigateTo: () async {
                  setState(() {
                    loading = true;
                  });
                  await anonymousSignIn(context);
                  setState(() {
                    loading = false;
                  });
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser?.emailVerified == true &&
          FirebaseAuth.instance.currentUser!.displayName != "amanexo") {
        return const HomeScreen();
      } else if (FirebaseAuth.instance.currentUser!.displayName == "amanexo") {
        return const AdminHome();
      } else if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser?.emailVerified == false) {
        return const Verify();
      } else {
        return wrap();
      }
    } catch (e) {
      return wrap();
    }
  }
}
