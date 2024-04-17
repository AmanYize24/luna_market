import 'package:flutter/material.dart';
import 'package:luna_market/functions/cloud_firestore_functions.dart';
import 'package:luna_market/provider/home_provider.dart';
import 'package:luna_market/provider/user_provider.dart';
import 'package:luna_market/screens/wrapper.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './provider/wrapper_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WrapperProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: ((context) => CartProvider()))
      ],
      child: const MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
