import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:luna_market/widgets/box.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
      ),
    body: ListView(children: [
      box(0, 25),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Column(children: [
        Row(children: [
        box(25,0),
        Text( style: GoogleFonts.inter(fontSize: 17, 
      fontWeight: FontWeight.bold),
      'Username: '), 
      Text(style: GoogleFonts.inter(fontSize: 17),
      FirebaseAuth.instance.currentUser!.displayName.toString())],),
        box(0,30),
      Row(children: [
        
        box(25,0),
        Text( style: GoogleFonts.inter(fontSize: 17, 
      fontWeight: FontWeight.bold),
      'Email: '), 
      Text(style: GoogleFonts.inter(fontSize: 17),
      FirebaseAuth.instance.currentUser!.email.toString())],),
       box(0, 30),
       Row(children: [
        box(25,0),
        Text( style: GoogleFonts.inter(fontSize: 17, 
      fontWeight: FontWeight.bold),
      'Phone: '), 
      Text(style: GoogleFonts.inter(fontSize: 17),
      FirebaseAuth.instance.currentUser!.phoneNumber.toString())],),
      ],),),
      box(0, 30),
      Align(alignment: Alignment.center, 
      child: SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(onPressed: (){
          showDialog(context: context, builder: (context)=>AlertDialog(title: const Text('change phone number'),
          content: TextField(controller: phoneController, decoration: const InputDecoration(hintText: 'please enter new phone number')),
          actions: [
            TextButton(onPressed: (){}, child: const Text('cancel')),
            TextButton(onPressed: ()async{
            await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phoneController.text,
            verificationCompleted: (PhoneAuthCredential credential) {
              Navigator.of(context).pop();
            },
            verificationFailed: (FirebaseAuthException e) {
             
              
            },
            codeSent: (String verificationId, int? resendToken) {
             
              showDialog(context: context, builder: (context)=> AlertDialog(title: const Text('please enter code'),content: const TextField(),actions: [
                TextButton(onPressed: (){}, child: const Text('cancel')),
                TextButton(onPressed: (){

                }, child: const Text('submit')),
              ],));
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
);    
            }, child: const Text('submit')),
          ],
          ));
        }, 
        child: const Text('Change phone number'),),),),
    ],),
    );
  }
}