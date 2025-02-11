import 'package:flutter/material.dart';
import 'package:petshop/components/homepage_components/item_card.dart';
import '../components/appbar_components/appbar.dart';
import '../components/homepage_components/product_slider.dart';
import '../components/navigation_breadcrumb.dart';

class Homepage extends StatefulWidget {
  final ScrollController scrollController;
  const Homepage({super.key, required this.scrollController});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double mainAxisSpacing = screenSize.height * 0.075;
    double cardHeight = screenSize.height * 0.2;
    int crossAxisCount = 6;
    int itemCount = 10;
    int mainAxisCount = (itemCount / crossAxisCount).ceil();

    double boxHeight =
        ((mainAxisCount * cardHeight) + (mainAxisCount * mainAxisSpacing)) *
            mainAxisCount;

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.075,
          vertical: screenSize.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductSlider(),
            SizedBox(height: screenSize.height * 0.03),
            Text(
              'PRODUTOS RECOMENDADOS',
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
                  crossAxisSpacing: screenSize.height * 0.03,
                  childAspectRatio: 1,
                ),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return ItemCard(
                    cardHeight: cardHeight,
                    initialRoute: 'Home',
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
