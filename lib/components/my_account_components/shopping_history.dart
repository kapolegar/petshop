import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/models/order.dart';
import 'package:petshop/models/cart_item.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/order_history_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/components/my_account_components/order_details.dart';

class ShoppingHistory extends StatefulWidget {
  const ShoppingHistory({super.key});

  @override
  State<ShoppingHistory> createState() => _ShoppingHistoryState();
}

class _ShoppingHistoryState extends State<ShoppingHistory> {
  DateTime? startDate;
  DateTime? endDate;

  Widget orderItem(
    Size screenSize,
    Order item,
    SelectScreen selectScreenProvider,
    MyAccount myAccountProvider,
  ) {
    return InkWell(
      onTap:
          () => myAccountProvider.updateAccountDetailsScreen(
            OrderDetails(order: item),
          ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: screenSize.height * 0.02,
          right: screenSize.width * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width * 0.125,

              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.01,
                vertical: screenSize.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenSize.height * 0.015),
                border: Border.all(color: Theme.of(context).primaryColorDark),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (CartItem product in item.itens)
                    item.itens.indexOf(product) <= 1
                        ? Image.asset(
                          product.product.imagemUrl,

                          height: screenSize.height * 0.075,
                          fit: BoxFit.cover,
                        )
                        : const SizedBox(),
                  item.itens.length > 2
                      ? Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColorDark,
                        size: screenSize.height * 0.05,
                      )
                      : const SizedBox(),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text('ID do Pedido: ${item.id}'),
            Text(DateFormat('dd/MM/yyyy').format(item.data)),
            Text(item.valorTotal.toString()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    OrderHistoryProvider orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);
    SelectScreen selectScreenProvider = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );

    return AnimatedContainer(
      width: screenSize.width * 0.6,
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
          Text('Meus Pedidos', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: screenSize.height * 0.03),
          Text(
            'Confira os detalhes dos seus pedidos.',
            style: TextStyle(
              fontFamily: 'NunitoSansBold',
              fontSize: screenSize.height * 0.018,
              fontWeight: FontWeight.normal,
              letterSpacing: screenSize.width * 0.0001,
              color: const Color.fromARGB(187, 0, 0, 0),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              for (Order item in orderHistoryProvider.orders)
                orderItem(
                  screenSize,
                  item,
                  selectScreenProvider,
                  myAccountProvider,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
