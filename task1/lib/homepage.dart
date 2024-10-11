import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        color: Color(0xFF3C2B2B),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80, left: 30),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/profilepic.png'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
