import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/providers/products_provider.dart';

class SearchBarPetShop extends StatefulWidget {
  const SearchBarPetShop({super.key});

  @override
  State<SearchBarPetShop> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarPetShop> {
  final TextEditingController _controller = TextEditingController();
  bool searchIsPressed = false;

  void _performSearch() {
    final productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );
    // final searchedText = _controller.text;
    // productsProvider.updateSearchedProducts(searchedText);
    context.goNamed(
      'produtos',
      queryParameters: {
        'filtro': [productsProvider.searchedProduct],
      },
    );
    _controller.clear();
    productsProvider.updateSearchedProducts('');
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ProductsProvider productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );

    return SizedBox(
      height: screenSize.height * 0.055,
      child: SearchBar(
        controller: _controller,
        backgroundColor: WidgetStateProperty.all<Color>(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        surfaceTintColor: WidgetStateProperty.all<Color>(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
        overlayColor: WidgetStateProperty.all<Color>(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: Theme.of(context).dividerColor),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
        ),
        hintText: 'O que seu pet precisa hoje?',
        hintStyle: WidgetStateProperty.all<TextStyle>(
          Theme.of(context).textTheme.labelSmall!,
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: screenSize.height * 0.018,
            letterSpacing: screenSize.width * 0.00075,
            fontWeight: FontWeight.bold,
            height: screenSize.height * 0.003,
            color: Colors.black,
          ),
        ),
        onChanged: (value) => productsProvider.updateSearchedProducts(value),
        onSubmitted: (value) => _performSearch(),
        trailing: [
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                searchIsPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                searchIsPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                searchIsPressed = false;
              });
            },
            child: IconButton(
              onPressed: _performSearch,
              icon: Icon(
                Icons.search_rounded,
                color:
                    searchIsPressed
                        ? Colors.white
                        : Theme.of(context).primaryColorDark,
                size: screenSize.height * 0.035,
              ),
              splashRadius: screenSize.height * 0.023,
            ),
          ),
        ],
      ),
    );
  }
}
