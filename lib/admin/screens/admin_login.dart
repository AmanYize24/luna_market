import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:luna_market/admin/admin_auth.dart';
import 'package:luna_market/widgets/box.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
              'Admin Login'),
        ),
        actions: [box(50, 0)],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2021/11/30/17/06/tree-6835828_960_720.jpg')),
            border: GradientBoxBorder(
                width: 5,
                gradient: LinearGradient(colors: [
                  Colors.pinkAccent.withOpacity(0.5),
                  Colors.purpleAccent.withOpacity(0.5)
                ]))),
        child: ListView(
          children: [
            box(0, 100),
            Align(
                alignment: Alignment.center,
                child: Text(
                    style: GoogleFonts.inter(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    'welcome to luna market')),
            box(0, 100),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 300,
                  height: 55,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'email',
                        hintStyle: GoogleFonts.inter(color: Colors.pinkAccent),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.white),
                  )),
            ),
            box(0, 20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: 300,
                  height: 55,
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'password',
                        hintStyle: GoogleFonts.inter(color: Colors.pinkAccent),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.white),
                  )),
            ),
            box(0, 50),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 300,
                height: 55,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    await getAdmin(
                        context: context,
                        emailIn: _emailController.text,
                        passwordIn: _passwordController.text);
                    setState(() {
                      _loading = false;
                    });
                  },
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          'Login'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
