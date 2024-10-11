import 'package:flutter/material.dart';
import 'package:task1/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyLogin()));
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
    ));
  }
}
