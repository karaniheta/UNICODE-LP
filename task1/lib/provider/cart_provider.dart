import 'package:flutter/material.dart';

import '../Models/posts_model.dart';

class Cart with ChangeNotifier {
  // final List<String> _items = [];
  final List<PostsModel> _items = [];
  List<PostsModel> get items => List.unmodifiable(_items);

  // List<String> get items => List.unmodifiable(_items);

  void addItem(PostsModel item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(PostsModel item) {
    _items.remove(item);
    notifyListeners();
  }

  int get itemCount => _items.length;
}
