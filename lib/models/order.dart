import 'package:petshop/models/cart_item.dart';

class Order {
  final String id;
  String clientID;
  final List<CartItem> itens;
  final DateTime data;
  String status;
  String formaPagamento;

  Order({
    required this.id,
    required this.clientID,
    required this.itens,
    required this.data,
    required this.status,
    required this.formaPagamento,
  });

  double get valorTotal {
    return itens.fold(
      0.0,
      (total, item) => total + double.parse(item.product.preco),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itens': itens.map((item) => item.product.toMap()).toList(),
      'data': data.toIso8601String(),
      'status': status,
      'formaPagamento': formaPagamento,
    };
  }
}
