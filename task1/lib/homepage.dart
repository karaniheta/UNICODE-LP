import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          color: Color(0xFF3C2B2B),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)), // Radius for rounded edges
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, bottom: 30),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/profilepic.png'),
                  ),
                )
              ],
            ),
            Padding(
              
              padding: const EdgeInsets.only(left:10,right: 10),
              child: SearchBar(
                controller: searchController,
                leading: IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.search)
                
                ),
                
                trailing: [
                IconButton( 
                  onPressed: () {}, 
                icon: const Icon(Icons.mic),
               
                
                ),],
                
                  //padding: const EdgeInsets.only(right: 10,left: 10) ,
                 //backgroundColor: Colors.white,
                hintText: 'Search...',
                // icon: Icon(Icons.search),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
