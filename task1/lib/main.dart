import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/bottomnavbar.dart';
import 'package:task1/firebase_options.dart';
import 'package:task1/SplashScreen.dart';
import 'package:task1/homepage.dart';
import 'package:task1/provider/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
      home: Splashscreen(),
        ),
    ));
}
