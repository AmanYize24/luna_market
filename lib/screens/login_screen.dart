import 'package:flutter/material.dart';

import 'package:luna_market/screens/sign_up.dart';

import '../widgets/wrapper_input.dart';
import '../widgets/box.dart';
import '../widgets/account_btn.dart';
import '../auth/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Create Account")),
        automaticallyImplyLeading: false,
      ),
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
              box(0, 150),
              wrapperInput(
                  hint: "email", hideText: false, controller: emailController),
              box(0, 30),
              wrapperInput(
                  hint: "password",
                  hideText: true,
                  controller: passwordController),
              box(0, 30),
              accountBtn(
                  choiceText: loading
                      ? const CircularProgressIndicator()
                      : const Text(
                          style: TextStyle(fontSize: 25, color: Colors.black),
                          "Login"),
                  userChoice: () async {
                    setState(() {
                      loading = true;
                    });
                    await signIn(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text);
                    setState(() {
                      loading = false;
                    });
                  }),
              box(0, 30),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        style: TextStyle(fontSize: 17),
                        "don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                            style: TextStyle(fontSize: 17, color: Colors.white),
                            "Create account"))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
