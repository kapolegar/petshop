import 'package:flutter/material.dart';
import 'package:petshop/models/order.dart';

class OrderHistoryProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  addOrder(Order orderItem) {
    _orders.add(orderItem);
    print(_orders.length);
    notifyListeners();
  }
}
