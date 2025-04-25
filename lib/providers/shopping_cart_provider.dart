import 'package:flutter/material.dart';
import 'package:petshop/models/cart_item.dart';

class ShoppingCartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  double get totalCartValue => _cartItems.fold(
    0.0,
    (total, item) => total + (item.quantity * double.parse(item.product.preco)),
  );
  int get totalCartItems =>
      _cartItems.fold(0, (total, item) => total + item.quantity);
  List<CartItem> get cartItems => _cartItems;

  addToCart(CartItem product) {
    _cartItems
            .where((element) => element.product.id == product.product.id)
            .toList()
            .isNotEmpty
        ? _cartItems
            .firstWhere((element) => element.product.id == product.product.id)
            .quantity += product.quantity
        : _cartItems.add(product);
    notifyListeners();
  }

  updateQuantity(CartItem item, int quantity) {
    item.quantity = quantity;
    notifyListeners();
  }

  cleanCart() {
    _cartItems.clear();
    notifyListeners();
  }

  removeFromCart(CartItem removedItem) {
    _cartItems.removeWhere((item) => item == removedItem);
    notifyListeners();
  }
}
