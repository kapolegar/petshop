import 'package:flutter/material.dart';
import 'package:petshop/components/homepage_components/item_card.dart';
import 'package:petshop/components/homepage_components/product_slider.dart';
import 'package:petshop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class HomeProductsPage extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> filteredItems;

  const HomeProductsPage({
    super.key,
    required this.scrollController,
    this.filteredItems = const [],
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );

    final allProducts = productsProvider.products;

    final filteredProducts =
        filteredItems.isEmpty
            ? allProducts
            : allProducts.where((product) {
              return filteredItems.every(
                (keyword) =>
                    product.categoria.toLowerCase().contains(
                      keyword.toLowerCase(),
                    ) ||
                    product.nome.toLowerCase().contains(
                      keyword.toLowerCase(),
                    ) ||
                    product.pet.toLowerCase().contains(keyword.toLowerCase()),
              );
            }).toList();

    final double mainAxisSpacing = screenSize.height * 0.05;
    final double cardHeight = screenSize.height * 0.2;
    final double totalCardHeight = screenSize.height * 0.45;
    const int crossAxisCount = 6;

    final boxHeight =
        (filteredProducts.length / crossAxisCount).ceil() *
        (totalCardHeight + mainAxisSpacing);

    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.075,
          vertical: screenSize.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductSlider(),
            SizedBox(height: screenSize.height * 0.05),
            Text(
              filteredItems.isEmpty
                  ? 'PRODUTOS RECOMENDADOS'
                  : filteredItems.join(', ').toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: screenSize.height * 0.03),
            SizedBox(
              height: boxHeight,
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: 0.9,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    cardHeight: cardHeight,
                    totalCardHeight: totalCardHeight,
                    initialRoute: 'home',
                    product: filteredProducts[index],
                  );
                },
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
