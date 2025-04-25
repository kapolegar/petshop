import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/models/product.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:petshop/models/cart_item.dart';
import '../providers/selected_screen_provider.dart';
import 'package:petshop/providers/shopping_cart_provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();
  int quantity = 1;

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _scale = 1.5;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _scale = 1.0;
      _offset = Offset.zero;
    });
  }

  void _onHover(PointerHoverEvent event, Size widgetSize) {
    final dx = ((event.localPosition.dx / widgetSize.width) - 0.5) * 200;
    final dy = ((event.localPosition.dy / widgetSize.height) - 0.5) * 200;

    setState(() {
      _offset = Offset(dx, dy);
    });
  }

  void _scrollToWidget() {
    final RenderBox renderBox =
        _targetKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero).dy;

    _scrollController.animateTo(
      position + _scrollController.offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final widgetSize = Size(screenSize.width * 0.3, screenSize.height * 0.5);
    SelectScreen selectedScreen = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    ShoppingCartProvider shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.075,
        vertical: screenSize.height * 0.03,
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NavigationBreadcrumb(product: widget.product),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MouseRegion(
                    onEnter: _onEnter,
                    onExit: _onExit,
                    onHover: (event) => _onHover(event, widgetSize),
                    child: SizedBox(
                      width: widgetSize.width,
                      height: widgetSize.height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 150),
                          tween: Tween<double>(begin: 1.0, end: _scale),
                          builder: (context, scale, child) {
                            return Transform(
                              alignment: Alignment.center,
                              transform:
                                  Matrix4.identity()
                                    ..translate(_offset.dx, _offset.dy)
                                    ..scale(scale),
                              child: child,
                            );
                          },
                          child: Image.asset(
                            widget.product.imagemUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.015),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.nome,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      Row(
                        children: [
                          Text(
                            'ID: ${widget.product.id}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.0075,
                            ),
                            child: Text(
                              '|',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _scrollToWidget();
                            },
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                            ),
                            child: Text(
                              'Ver descrição completa',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Text(
                        'R\$ 35,00',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      Row(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.06,
                            width: screenSize.width * 0.075,
                            child: SpinBox(
                              min: 1,
                              max: 100,
                              value: 1,
                              onChanged:
                                  (value) =>
                                      quantity = int.parse((value).toString()),
                              textStyle: TextStyle(
                                fontFamily: 'NunitoSansBold',
                                fontSize: screenSize.height * 0.016,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.01),
                          SizedBox(
                            width: screenSize.width * 0.25,
                            height: screenSize.height * 0.06,
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
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                              onPressed: () {
                                shoppingCartProvider.addToCart(
                                  CartItem(
                                    product: widget.product,
                                    quantity: quantity,
                                  ),
                                );
                                selectedScreen.scaffoldKey.currentState
                                    ?.openEndDrawer();
                              },
                              child: Text(
                                'Adicionar ao carrinho',
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
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Text(
              'DESCRIÇÃO DO PRODUTO',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: screenSize.height * 0.015),
            SizedBox(
              width: screenSize.width * 0.5,
              child: Text(
                '- Praesent in quam ac nisl sollicitudin rutrum at nec diam.\n- Aenean at erat nec mi ornare lacinia sed nec nisi.\n- Aenean sit amet orci pellentesque, cursus purus ac, dapibus erat.\n- Aenean sit amet urna nec lectus imperdiet facilisis.\n- Duis id nisi eget nulla pulvinar sollicitudin at at est.\n- Praesent in quam ac nisl sollicitudin rutrum at nec diam.\n- Aenean at erat nec mi ornare lacinia sed nec nisi.\n- Aenean sit amet orci pellentesque, cursus purus ac, dapibus erat.',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            SizedBox(height: screenSize.height * 0.015, key: _targetKey),
          ],
        ),
      ),
    );
  }
}
