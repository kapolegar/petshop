import 'package:petshop/models/product.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double totalValue() {
    return double.parse(product.preco) * quantity;
  }
}
