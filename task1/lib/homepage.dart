import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFF3C2B2B),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight:
                          Radius.circular(50)), // Radius for rounded edges
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 30, bottom: 30),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                AssetImage('assets/profilepic.png'),
                          ),
                        ),
                        Text('     abvn'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SearchBar(
                        controller: searchController,
                        leading: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),

                        trailing: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.mic),
                          ),
                        ],

                        //padding: const EdgeInsets.only(right: 10,left: 10) ,
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        hintText: 'Search...',
                        // icon: Icon(Icons.search),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: Container(
                  height: 150,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(0x86997E6B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 200),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: CircleAvatar(
                    radius: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20),
                child: Text(
                  'Cappuccino',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
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
