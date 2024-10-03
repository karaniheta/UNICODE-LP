import 'package:task1/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeShop extends ChangeNotifier {
  final List<Coffee> _shop = [
    Coffee(name: 'Long Black', price: "250", imagePath: "assets/coffee.png"),
    Coffee(name: 'Latte', price: "350", imagePath: "assets/cup.png"),
    Coffee(name: 'Espresso', price: "250", imagePath: "assets/espresso.png"),
    Coffee(
        name: 'Iced Coffee', price: "250", imagePath: "assets/latte-art.png"),
  ];

  // user cart
  List<Coffee> _userCart = [];

  // grt coffee list
  List<Coffee> get coffeeShop => _shop;

  // get user cart
  List<Coffee> get userCart => _userCart;

  void addItemToCart(Coffee coffee) {
    _userCart.add(coffee);
    notifyListeners();
  }

  void removeItemToCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }
}
