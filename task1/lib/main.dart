import 'package:flutter/material.dart';
import 'package:task1/login.dart';
import 'package:task1/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, //remove debuge
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin()
      },
  ));
}
