import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/firebase_options.dart';
import 'package:task1/home.dart';
import 'package:task1/login.dart';
import 'package:task1/models/coffee_shop.dart';
import 'package:task1/register.dart';
import 'package:task1/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => CoffeeShop(),
    builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false, //remove debuge
      home: Splash(),
      initialRoute: 'login',
      routes: {
        'login': (context) => MyLogin(),
        'register': (context) => MyRegister(),
        'home': (context) => HomePage(),
      },
    ),
  ));
}
