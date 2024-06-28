import 'package:flutter/material.dart';
import 'package:luna_market/screens/login_screen.dart';
import 'package:luna_market/widgets/account_btn.dart';
import 'package:luna_market/widgets/box.dart';
import 'package:luna_market/widgets/wrapper_input.dart';
import '../auth/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  bool loading = false;
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
              box(0, 100),
              wrapperInput(
                  hint: "username",
                  hideText: false,
                  controller: displayNameController),
              box(0, 30),
              wrapperInput(
                  hint: "email", hideText: false, controller: emailController),
              box(0, 30),
              wrapperInput(
                  hint: "create password",
                  hideText: true,
                  controller: passwordController),
              box(0, 30),
              wrapperInput(
                  hint: "confirm password",
                  hideText: true,
                  controller: confirmPasswordController),
              box(0, 50),
              accountBtn(
                  choiceText: loading
                      ? const CircularProgressIndicator()
                      : const Text(
                          style: TextStyle(fontSize: 25, color: Colors.black),
                          "Create Account"),
                  userChoice: () async {
                    setState(() {
                      loading = true;
                    });
                    await createUser(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        displayName: displayNameController.text);
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
                        "Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                            style: TextStyle(fontSize: 17, color: Colors.white),
                            "Login"))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
