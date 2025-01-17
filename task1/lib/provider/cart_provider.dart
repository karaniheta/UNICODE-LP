import 'package:flutter/material.dart';
import '../Models/posts_model.dart';

class Cart with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  final double placeholderPrice = 10.0; // Each item with quantity
  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  void addItem(PostsModel item) {
    final index = _items.indexWhere((element) => element['item'] == item);
    if (index >= 0) {
      _items[index]['quantity']++; // Increase quantity if item exists
    } else {
      _items.add({'item': item, 'quantity': 1}); // Add new item with quantity 1
    }
    notifyListeners();
  }

  void removeItem(PostsModel item) {
    final index = _items.indexWhere((element) => element['item'] == item);
    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void increaseQuantity(PostsModel item) {
    final index = _items.indexWhere((element) => element['item'] == item);
    if (index >= 0) {
      _items[index]['quantity']++;
      notifyListeners();
    }
  }

  void decreaseQuantity(PostsModel item) {
    final index = _items.indexWhere((element) => element['item'] == item);
    if (index >= 0) {
      if (_items[index]['quantity'] > 1) {
        _items[index]['quantity']--;
      } else {
        _items.removeAt(index); // Remove item if quantity is 1
      }
      notifyListeners();
    }
  }
  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      final int quantity = item['quantity'];
      total += placeholderPrice * quantity; // Use placeholder price
    }
    return total;
  }

  int get itemCount => _items.length;
}
