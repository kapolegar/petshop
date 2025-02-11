import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Drawer(
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
                  )
                ]),
          ),
          Divider(),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///////////////////////////////////////////////////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
                    child: SizedBox(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Image.asset(
                                  'images/products/racao_gato1.jpg',
                                  width: screenSize.width * 0.1,
                                  height: screenSize.height * 0.15,
                                  fit: BoxFit.fitHeight,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Exemplo Produto',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.015,
                                      ),
                                      Text(
                                        'R\$ 35,00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.015,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.025),
                                  child: IconButton(
                                      onPressed: () {},
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Theme.of(context).highlightColor,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.07,
                                  width: screenSize.width * 0.1,
                                  child: SpinBox(
                                    min: 1,
                                    max: 100,
                                    value: 1,
                                    onChanged: (value) =>
                                        print('Valor: $value'),
                                    textStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .dividerColor))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
                    child: SizedBox(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Image.asset(
                                  'images/products/racao_gato1.jpg',
                                  width: screenSize.width * 0.1,
                                  height: screenSize.height * 0.15,
                                  fit: BoxFit.fitHeight,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Exemplo Produto',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.015,
                                      ),
                                      Text(
                                        'R\$ 35,00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.015,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.025),
                                  child: IconButton(
                                      onPressed: () {},
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Theme.of(context).highlightColor,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.07,
                                  width: screenSize.width * 0.1,
                                  child: SpinBox(
                                    min: 1,
                                    max: 100,
                                    value: 1,
                                    onChanged: (value) =>
                                        print('Valor: $value'),
                                    textStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .dividerColor))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
                    child: SizedBox(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Image.asset(
                                  'images/products/racao_gato1.jpg',
                                  width: screenSize.width * 0.1,
                                  height: screenSize.height * 0.15,
                                  fit: BoxFit.fitHeight,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Exemplo Produto',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      SizedBox(
                                        height: screenSize.height * 0.015,
                                      ),
                                      Text(
                                        'R\$ 35,00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.015,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.025),
                                  child: IconButton(
                                      onPressed: () {},
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Theme.of(context).highlightColor,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: screenSize.height * 0.07,
                                  width: screenSize.width * 0.1,
                                  child: SpinBox(
                                    min: 1,
                                    max: 100,
                                    value: 1,
                                    onChanged: (value) =>
                                        print('Valor: $value'),
                                    textStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .dividerColor))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ///////////////////////////////////////////////////////////////////////////////////////////
                ],
              ),
            ),
          ),
          Divider(),
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
                        'R\$ 0,00',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.075,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.height * 0.015),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor)),
                        onPressed: () {},
                        child: Text(
                          'Fechar Pedido',
                          style: TextStyle(
                            fontFamily: 'NunitoSansBold',
                            fontSize: screenSize.height * 0.022,
                            fontWeight: FontWeight.bold,
                            letterSpacing: screenSize.width * 0.0001,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        )),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
