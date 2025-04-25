import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/models/product.dart';
import 'package:petshop/models/cart_item.dart';
import 'package:petshop/screens/product_details.dart';
import 'package:petshop/providers/shopping_cart_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';

class ItemCard extends StatefulWidget {
  final double cardHeight;
  final double totalCardHeight;
  final String initialRoute;
  final Product product;
  const ItemCard({
    super.key,
    required this.cardHeight,
    required this.totalCardHeight,
    required this.initialRoute,
    required this.product,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SelectScreen selectedScreen = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    ShoppingCartProvider shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);

    return SizedBox(
      height: widget.totalCardHeight,
      width: widget.cardHeight,
      child: ElevatedButton(
        onPressed: () {
          final currentUri = Uri.base;
          final filtros = currentUri.queryParametersAll['filtro'] ?? [];
          final novaUri = Uri(
            path: '/produtos/detalhes-produto/${widget.product.nome}',
            queryParameters: {'filtro': filtros},
          );
          context.go(novaUri.toString(), extra: widget.product);
          selectedScreen.changeScreen(ProductDetails(product: widget.product));
          selectedScreen.addRoute(widget.initialRoute);
          selectedScreen.addRoute(widget.product.nome);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widget.cardHeight,
              height: widget.cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenSize.height * 0.01),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.product.imagemUrl,
                        width: screenSize.width * 0.1,
                        height: screenSize.height * 0.1,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      mini: true,
                      onPressed: () {
                        shoppingCartProvider.addToCart(
                          CartItem(product: widget.product, quantity: 1),
                        );
                      },
                      child: const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.01,
                bottom: screenSize.height * 0.005,
              ),
              child: Text(
                widget.product.nome,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: screenSize.height * 0.018,
                  fontWeight: FontWeight.bold,
                  letterSpacing: screenSize.width * 0.0001,
                  color: const Color.fromARGB(187, 0, 0, 0),
                ),
              ),
            ),
            Text(
              'R\$ ${(double.parse(widget.product.preco)).toStringAsFixed(2).replaceAll('.', ',')}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
