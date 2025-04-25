import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/models/cart_item.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:petshop/providers/shopping_cart_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ShoppingCartProvider shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
    SelectScreen selectScreenProvider = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    return Consumer<ShoppingCartProvider>(
      builder: (context, cart, child) {
        return Drawer(
          backgroundColor: Colors.white,
          width: screenSize.width * 0.3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenSize.height * 0.03),
              bottomLeft: Radius.circular(screenSize.height * 0.03),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: screenSize.width * 0.025,
                  left: screenSize.width * 0.025,
                  top: screenSize.height * 0.04,
                  bottom: screenSize.height * 0.01,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Confira sua compra',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(
                        Icons.close_rounded,
                        size: screenSize.height * 0.035,
                        weight: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (CartItem item in shoppingCartProvider.cartItems)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: screenSize.height * 0.03,
                          ),
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Container(
                                        height: screenSize.height * 0.15,
                                        width: screenSize.height * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            screenSize.height * 0.01,
                                          ),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).dividerColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: Image.asset(
                                          item.product.imagemUrl,
                                          width: screenSize.height * 0.12,
                                          height: screenSize.height * 0.12,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
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
                                          SizedBox(
                                            height: screenSize.height * 0.015,
                                          ),
                                          Text(
                                            'R\$ ${item.product.preco.toString().replaceAll('.', ',')}',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.labelMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.015,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
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
                                          SizedBox(
                                            height: screenSize.height * 0.02,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(
                  right: screenSize.width * 0.025,
                  left: screenSize.width * 0.025,
                  top: screenSize.height * 0.03,
                  bottom: screenSize.height * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          'R\$ ${shoppingCartProvider.totalCartValue.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    SizedBox(
                      width: screenSize.width * 0.25,
                      height: screenSize.height * 0.075,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenSize.height * 0.015,
                                  ),
                                ),
                              ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          selectScreenProvider.scaffoldKey.currentState
                              ?.closeEndDrawer();
                          context.goNamed('carrinho');
                        },
                        child: Text(
                          'Ir para carrinho',
                          style: TextStyle(
                            fontFamily: 'NunitoSansBold',
                            fontSize: screenSize.height * 0.022,
                            fontWeight: FontWeight.bold,
                            letterSpacing: screenSize.width * 0.0001,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
