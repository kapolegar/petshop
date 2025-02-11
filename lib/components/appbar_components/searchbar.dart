import 'package:flutter/material.dart';

class SearchBarPetShop extends StatefulWidget {
  const SearchBarPetShop({super.key});

  @override
  State<SearchBarPetShop> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarPetShop> {
  bool searchIsPressed = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.055,
      child: SearchBar(
        surfaceTintColor: MaterialStateProperty.all<Color>(
            Theme.of(context).scaffoldBackgroundColor),
        shadowColor: MaterialStateProperty.all<Color>(
            Theme.of(context).scaffoldBackgroundColor),
        overlayColor: MaterialStateProperty.all<Color>(
            Theme.of(context).scaffoldBackgroundColor),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: Theme.of(context).dividerColor),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: screenSize.width * 0.01)),
        hintText: 'O que seu pet precisa hoje?',
        hintStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.labelSmall!),
        textStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodyMedium!),
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
              onPressed: () {
                print(searchIsPressed);
              },
              icon: Icon(
                Icons.search_rounded,
                color: searchIsPressed
                    ? Colors.white
                    : Theme.of(context).highlightColor,
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
