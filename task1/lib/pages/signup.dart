import 'package:flutter/material.dart';
import 'package:task1/authservice.dart';
import 'package:task1/bottomnavbar.dart';
import 'package:task1/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({super.key});

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _name.dispose();
  }

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
            height: 375,
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
                            "Sign Up",
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 10))),
                          controller: _name),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
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
                          style: TextStyle(color: Colors.white),
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
                        onPressed: _signup,
                        child: Text("SignUp"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Bottomnavbar()));
                        },
                        child: Text(
                          "Alreay have an account? SignIn",
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

  void _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      print("User Created Succesfully");

      await FirebaseFirestore.instance.collection('Cafe').doc(user.uid).set({
        'name': _name.text,
        'email': _email.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Replace this with your actual mobile controller or input

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Bottomnavbar()));
    }
  }
}
