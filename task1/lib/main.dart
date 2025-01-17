import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:task1/bottomnavbar.dart';
import 'package:task1/firebase_options.dart';
import 'package:task1/pages/SplashScreen.dart';
import 'package:task1/pages/homepage.dart';
import 'package:task1/provider/cart_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    ),
  ));
}
