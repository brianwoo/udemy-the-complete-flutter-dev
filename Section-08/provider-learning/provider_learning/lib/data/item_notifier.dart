import 'dart:collection';
import 'package:flutter/material.dart';

class ItemNotifier extends ChangeNotifier {
  final List<String> _items = <String>[];
  int _size = 0;

  List<String> getItems() => UnmodifiableListView(_items);
  int getSize() => _size;

  void add(String value) {
    _items.add(value);
    _size++;
    notifyListeners();
  }

  void delete(int index) {
    _items.removeAt(index);
    _size--;
    notifyListeners();
  }

  void modify(int index, String data) {
    _items[index] = data;
    notifyListeners();
  }
}
