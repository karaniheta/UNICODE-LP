import 'package:flutter/material.dart';
import 'package:task1/drinkmenu.dart';
import 'package:task1/favorite.dart';
import 'package:task1/homepage.dart';
import 'package:task1/order.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int myIndex = 0;
  List<Widget> widgetList = [
    MyHomePage(),
    Mydrinkmenu(),
    Myorder(),
    MyFavorite()
    // Text('Drink Menu', style: TextStyle(fontSize: 30)),
    //Text('Your Order', style: TextStyle(fontSize: 30)),
    //Text('Favorite', style: TextStyle(fontSize: 30)),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
         
        
         bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          iconSize: 30,
          backgroundColor: Color(0xFF834D1E),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',

              //backgroundColor: Color.fromARGB(255, 255, 255, 255)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe, color: Colors.white),
              label: 'Drink Menu',
              //backgroundColor: Color.fromARGB(255, 255, 255, 255)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long, color: Colors.white),
              label: 'Your Order',
              //backgroundColor: Color.fromARGB(255, 255, 255, 255)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.white),
              label: 'Favorites',
              //backgroundColor: Color.fromARGB(255, 255, 255, 255)
            ),
          ]),
          body: Center(
            child: widgetList[myIndex],
          ),
      ) 
    );
  }
}