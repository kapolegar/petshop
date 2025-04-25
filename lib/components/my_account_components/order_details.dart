import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:petshop/models/order.dart';
import 'package:petshop/models/cart_item.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  const OrderDetails({required this.order, super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final List<String> _orderStatus = [
    'Pedido Realizado',
    'Pedido Aprovado',
    'Em Separação',
    'Na Entrega',
    'Entregue',
  ];

  Widget _itemsList(Size screenSize, CartItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.015),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenSize.height * 0.01),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        padding: EdgeInsets.only(
          top: screenSize.height * 0.025,
          bottom: screenSize.height * 0.025,
          left: screenSize.height * 0.025,
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenSize.height * 0.1,
              width: screenSize.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenSize.height * 0.01),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Image.asset(item.product.imagemUrl, fit: BoxFit.fill),
            ),
            SizedBox(width: screenSize.width * 0.015),
            SizedBox(
              width: screenSize.width * 0.225,
              child: Text(
                item.product.nome,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: screenSize.height * 0.018,
                  fontWeight: FontWeight.bold,
                  letterSpacing: screenSize.width * 0.0001,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.1,
              child: Text(
                'R\$ ${item.product.preco.toString().replaceAll('.', ',')}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.1,
              child: Text(
                '${item.quantity.toString()} un.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.1,
              child: Text(
                'R\$ ${(double.parse(item.product.preco) * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(screenSize.height * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
        borderRadius: BorderRadius.circular(screenSize.height * 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detalhes do Pedido nº ${widget.order.id.toString()}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: screenSize.height * 0.025),
          Text(
            'Pedido confirmado no dia ${DateFormat('dd/MM/yyyy').format(widget.order.data)}',
          ),
          SizedBox(height: screenSize.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (String status in _orderStatus)
                        Container(
                          width: screenSize.width * 0.1,
                          alignment: Alignment.center,
                          child: Text(status),
                        ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  SizedBox(
                    width: screenSize.width * 0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (String status in _orderStatus)
                          Row(
                            children: [
                              Container(
                                height: screenSize.height * 0.035,
                                width: screenSize.height * 0.035,
                                decoration: BoxDecoration(
                                  color:
                                      _orderStatus.indexOf(status) <=
                                              _orderStatus.indexOf(
                                                widget.order.status,
                                              )
                                          ? Theme.of(context).primaryColorDark
                                          : Colors.white,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    screenSize.height * 0.035,
                                  ),
                                ),
                              ),
                              status == _orderStatus.last
                                  ? const SizedBox()
                                  : Container(
                                    width: screenSize.width * 0.08325,
                                    height: screenSize.height * 0.0025,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.05),
          Text('${widget.order.itens.length.toString()} itens'),
          SizedBox(height: screenSize.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.3,
                alignment: Alignment.centerLeft,
                child: const Text('Produto'),
              ),
              Container(
                width: screenSize.width * 0.1,
                alignment: Alignment.center,
                child: const Text('Preço'),
              ),
              Container(
                width: screenSize.width * 0.1,
                alignment: Alignment.center,
                child: const Text('Quantidade'),
              ),
              Container(
                width: screenSize.width * 0.1,
                alignment: Alignment.center,
                child: const Text('Valor Total'),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.015),
          Column(
            children: [
              for (CartItem item in widget.order.itens)
                _itemsList(screenSize, item),
            ],
          ),
        ],
      ),
    );
  }
}
