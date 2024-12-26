import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:task1/SplashScreen.dart';
import 'package:task1/authservice.dart';
import 'package:task1/bottomnavbar.dart';
import 'package:task1/homepage.dart';
import 'package:task1/signup.dart';

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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: 900,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                  // add remainong code
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                      right: 25,
                      left: 25),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 10))),
                        controller: _email,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 10))),
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
      ),
    ));
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
