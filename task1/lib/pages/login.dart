import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:task1/pages/SplashScreen.dart';
import 'package:task1/authservice.dart';
import 'package:task1/bottomnavbar.dart';
import 'package:task1/pages/homepage.dart';
import 'package:task1/pages/signup.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});
  @override
  State<MyLoginPage> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLoginPage> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF7C5028),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                // Add Caffinity app name
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: AssetImage('assets/Caffinity.png'),
                            fit: BoxFit.cover)),
                    // backgroundImage: AssetImage('assets/Caffinity.png'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 30, left: 30, bottom: 150),
                  child: Container(
                    width: 350,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.005,
                              right: 25,
                              left: 25),
                          child: Column(
                            children: [
                              TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                            width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                            width: 2))),
                                controller: _email,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid,
                                              width: 2))),
                                  controller: _password),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: _signin,
                                child: Text("SignIn"),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 10),
                                  textStyle: TextStyle(fontSize: 20),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MySignUp()));
                                },
                                child: Text(
                                  "Don't have an account? SignUp",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signin() async {
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      print("User Created Succesfully");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Bottomnavbar()));
    }
  }
}
