
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  late bool allChecked = false;
  late bool isChecked = false;

  void setAllChecked() {
    allChecked = !allChecked;
    notifyListeners();
  }
  void setIsChecked(bool v) {
    isChecked = v;
    notifyListeners();
  }

  final List<int> itemIds = [];
  /// List of items in the cart.
  // List<Item> get items => itemIds.map((id) => catalog123.getById(id)).toList();

  /// The current total price of all items.
  // int get totalPrice =>
  //     items.fold(0, (total, current) => total + current.price);
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
  // To make the sample app look nicer, each item is given one of the
  // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}