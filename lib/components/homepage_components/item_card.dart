import 'package:flutter/material.dart';
import 'package:petshop/screens/product_details.dart';
import 'package:provider/provider.dart';

import '../../providers/selected_screen_provider.dart';

class ItemCard extends StatefulWidget {
  final double cardHeight;
  final String initialRoute;
  const ItemCard(
      {super.key, required this.cardHeight, required this.initialRoute});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SelectScreen selectedScreen =
        Provider.of<SelectScreen>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        selectedScreen.changeScreen(const ProductDetails(
          image: 'images/products/racao_gato1.jpg',
        ));
        selectedScreen.addRoute(widget.initialRoute);
        selectedScreen.addRoute('Exemplo Produto');
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
                      'images/products/racao_gato1.jpg',
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
                      selectedScreen.scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: const Icon(Icons.add_circle_rounded,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenSize.height * 0.01,
                bottom: screenSize.height * 0.005),
            child: Text(
              'Exemplo Produto',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            'R\$ 35,00',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
