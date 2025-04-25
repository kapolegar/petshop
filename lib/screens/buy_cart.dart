import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/models/order.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:petshop/models/cart_item.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/order_history_provider.dart';
import 'package:petshop/providers/shopping_cart_provider.dart';

class BuyCart extends StatefulWidget {
  const BuyCart({super.key});

  @override
  State<BuyCart> createState() => _BuyCartState();
}

class _BuyCartState extends State<BuyCart> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );
    ShoppingCartProvider shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
    OrderHistoryProvider orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);

    return Material(
      child: Consumer<ShoppingCartProvider>(
        builder: (context, cart, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: screenSize.width * 0.06),
                        ElevatedButton(
                          onPressed: () {
                            context.goNamed('home');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenSize.width * 0.015,
                            ),
                            child: Image.asset(
                              'assets/images/petshop_logo.png',
                              width: screenSize.width * 0.08,
                              height: screenSize.height * 0.12,
                            ),
                          ),
                        ),
                        Text(
                          'FOFINHOS PETSHOP',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),

              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: screenSize.width * 0.075),
                        Text(
                          'Carrinho de compras',
                          style: TextStyle(
                            fontFamily: 'NunitoSansBold',
                            fontSize: screenSize.height * 0.032,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: screenSize.width * 0.075),
                        SizedBox(
                          width: screenSize.width * 0.6,
                          height: screenSize.height * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (CartItem item
                                    in shoppingCartProvider.cartItems)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: screenSize.height * 0.025,
                                      right: screenSize.width * 0.01,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          screenSize.height * 0.01,
                                        ),
                                        border: Border.all(
                                          color: Theme.of(context).dividerColor,
                                          width: 1,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(
                                        screenSize.height * 0.02,
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: screenSize.height * 0.1,
                                            width: screenSize.height * 0.1,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    screenSize.height * 0.01,
                                                  ),
                                              border: Border.all(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).dividerColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Image.asset(
                                              item.product.imagemUrl,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.015,
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.2,
                                            child: Text(
                                              item.product.nome,
                                              style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontSize:
                                                    screenSize.height * 0.018,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing:
                                                    screenSize.width * 0.0001,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.015,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: screenSize.width * 0.075,
                                            child: Text(
                                              'R\$ ${item.product.preco.toString().replaceAll('.', ',')}',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.labelMedium,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.015,
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.05,
                                            width: screenSize.width * 0.07,
                                            child: SpinBox(
                                              min: 1,
                                              max: 100,
                                              value: double.parse(
                                                item.quantity.toString(),
                                              ),
                                              iconSize:
                                                  screenSize.height * 0.02,
                                              iconColor:
                                                  WidgetStateProperty.all<
                                                    Color
                                                  >(
                                                    Theme.of(
                                                      context,
                                                    ).primaryColorDark,
                                                  ),
                                              onChanged: (value) {
                                                shoppingCartProvider
                                                    .updateQuantity(
                                                      item,
                                                      int.parse(
                                                        value.toStringAsFixed(
                                                          0,
                                                        ),
                                                      ),
                                                    );
                                              },
                                              textStyle:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                              decoration: InputDecoration(
                                                hoverColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Theme.of(
                                                              context,
                                                            ).dividerColor,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.01,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: screenSize.width * 0.075,
                                            child: Text(
                                              'R\$ ${(double.parse(item.product.preco) * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.labelMedium,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.01,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              shoppingCartProvider
                                                  .removeFromCart(item);
                                            },
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).primaryColorDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.02),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                screenSize.height * 0.01,
                              ),
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.all(screenSize.height * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Resumo do pedido',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                SizedBox(height: screenSize.height * 0.05),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Valor dos produtos(${shoppingCartProvider.totalCartItems.toString()} ${shoppingCartProvider.totalCartItems == 1 ? 'item):' : 'itens):'}',
                                    ),
                                    Text(
                                      'R\$ ${shoppingCartProvider.totalCartValue.toStringAsFixed(2)}',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenSize.height * 0.1),
                                SizedBox(
                                  width: screenSize.width * 0.3,
                                  height: screenSize.height * 0.075,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder
                                      >(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            screenSize.height * 0.015,
                                          ),
                                        ),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                            Theme.of(context).primaryColor,
                                          ),
                                    ),
                                    onPressed:
                                        myAccountProvider.loggedUserInfos ==
                                                null
                                            ? () {
                                              List<CartItem> itens = List.from(
                                                shoppingCartProvider.cartItems,
                                              );
                                              Order order = Order(
                                                id:
                                                    (orderHistoryProvider
                                                                .orders
                                                                .length +
                                                            1)
                                                        .toString(),
                                                clientID: '',
                                                itens: itens,
                                                data: DateTime.now(),
                                                status: 'Pedido Realizado',
                                                formaPagamento: '',
                                              );
                                              orderHistoryProvider.addOrder(
                                                order,
                                              );
                                              context.goNamed(
                                                'login',
                                                extra: {
                                                  'fromScreen': BuyCart,
                                                  'orderID': order.id,
                                                },
                                              );
                                            }
                                            : () {
                                              List<CartItem> itens = List.from(
                                                shoppingCartProvider.cartItems,
                                              );
                                              Order order = Order(
                                                id:
                                                    (orderHistoryProvider
                                                                .orders
                                                                .length +
                                                            1)
                                                        .toString(),
                                                clientID:
                                                    myAccountProvider
                                                        .loggedUserInfos!
                                                        .id
                                                        .toString(),
                                                itens: itens,
                                                data: DateTime.now(),
                                                status: 'Pedido Realizado',
                                                formaPagamento: '',
                                              );
                                              orderHistoryProvider.addOrder(
                                                order,
                                              );
                                              context.goNamed(
                                                'pagamento',
                                                pathParameters: {
                                                  'orderID': order.id,
                                                },
                                              );
                                            },
                                    child: Text(
                                      'Ir para pagamento',
                                      style: TextStyle(
                                        fontFamily: 'NunitoSansBold',
                                        fontSize: screenSize.height * 0.022,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing:
                                            screenSize.width * 0.0001,
                                        color: const Color.fromRGBO(
                                          255,
                                          255,
                                          255,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.075),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
