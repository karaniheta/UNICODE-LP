import 'package:flutter/material.dart';
import 'package:task1/pages/login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 900,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/SplashScreen.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
