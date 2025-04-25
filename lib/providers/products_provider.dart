import 'dart:convert';
import '../models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = [];
  String _searchedProduct = '';

  List<Product> get products => _products;
  String get searchedProduct => _searchedProduct;

  updateSearchedProducts(String searchInput) {
    _searchedProduct = searchInput;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    try {
      final String response = await rootBundle.loadString('data/products.json');
      final List<dynamic> data = json.decode(response);

      _products.clear();
      _products.addAll(data.map((item) => Product.fromJson(item)).toList());

      notifyListeners();
    } catch (error) {
      print("Erro ao carregar produtos: $error");
    }
  }
}
