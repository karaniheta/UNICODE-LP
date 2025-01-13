import 'package:flutter/material.dart';
import 'package:task1/pages/drinkmenu.dart';
import 'package:task1/pages/profile.dart';
import 'package:task1/pages/homepage.dart';
import 'package:task1/pages/cart.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int currentTab = 0;

  final Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };

  final List<Widget> pages = [
     MyHomePage(),
     Mydrinkmenu(),
     MyCartPage(),
     MyProfile(),
  ];

  void _selectTab(int index) {
    if (index == currentTab) {
      // Pop to the first route if already on the current tab
      navigatorKeys[index]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentTab = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: List.generate(pages.length, (index) {
            return Offstage(
              offstage: currentTab != index,
              child: TabNavigator(
                navigatorKey: navigatorKeys[index]!,
                child: pages[index],
              ),
            );
          }),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: _selectTab,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          iconSize: 30,
          backgroundColor: const Color(0xFF834D1E),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe, color: Colors.white),
              label: 'Drink Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  const TabNavigator(
      {required this.navigatorKey, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => child,
      ),
    );
  }
}
