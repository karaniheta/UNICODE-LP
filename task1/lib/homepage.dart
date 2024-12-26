import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:task1/Models/posts_model.dart';
import 'package:task1/drinkmenu.dart';
import 'package:task1/drinkmenu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();

  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(
        Uri.parse('https://unicode-flutter-lp.onrender.com/get_all_products'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      //print(data);
      for (var i in data) {
        postList.add(PostsModel.fromJson(i));
        print("object");
      }
      print(postList[1].category);
      setState(() {});
      return postList;
    } else {
      print('ahmvhgdcfhgjgmnb');
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF8E3B6),
        title: Text(
          "Good Day,Heta",
          style: TextStyle(color: Color(0xFF834D1E), fontSize: 22),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu))
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 690,
                  decoration: BoxDecoration(color: Color(0xFFF8E3B6)),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Container(
                          height: 170,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color(0xFF834D1E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 220),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/image1.png'))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 350,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 130),
                        child: Text("This week's recommendations"),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 200,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/image2.png'),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 200,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/image3.png'),
                                          fit: BoxFit.cover)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 200,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/image1.png'),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 200,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/image3.png'),
                                          fit: BoxFit.cover)),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
