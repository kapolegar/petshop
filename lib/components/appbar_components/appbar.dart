import 'package:flutter/material.dart';
import 'package:petshop/components/appbar_components/searchbar.dart';
import 'package:petshop/screens/contact.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/products.dart';
import 'package:petshop/screens/services.dart';
import 'package:provider/provider.dart';

import '../../providers/selected_screen_provider.dart';

class AppBarPetShop extends StatefulWidget {
  final bool showBottom;
  final bool isOnHiddenScreen;
  final ScrollController scrollController;

  const AppBarPetShop(
      {super.key,
      required this.scrollController,
      required this.showBottom,
      required this.isOnHiddenScreen});

  @override
  State<AppBarPetShop> createState() => _AppBarPetShopState();
}

class _AppBarPetShopState extends State<AppBarPetShop> {
  bool accountIsPressed = false;
  bool contactIsPressed = false;
  bool cartIsPressed = false;

  late List<bool> selectionIsPressed;
  late List<bool> copySelectionIsPressed;

  void _onPressed(int index) {
    setState(() {
      for (int i = 0; i < selectionIsPressed.length; i++) {
        selectionIsPressed[i] = i == index;
        copySelectionIsPressed[i] = i == index;
      }
    });
  }

  @override
  void initState() {
    selectionIsPressed = [true, false, false];
    copySelectionIsPressed = List.from(selectionIsPressed);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SelectScreen selectedScreen =
        Provider.of<SelectScreen>(context, listen: false);

    Map<String, dynamic> selection = {
      'HOME': Homepage(
        scrollController: widget.scrollController,
      ),
      'PRODUTOS': const ProductsPage(),
      'SERVIÇOS': const ServicesPage()
    };

    return AppBar(
      elevation: 0,
      bottom: (widget.showBottom && !widget.isOnHiddenScreen)
          ? PreferredSize(
              preferredSize: Size.fromHeight(screenSize.height * 0.15),
              child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.015),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: selection.keys.map((item) {
                        int index = selection.keys.toList().indexOf(item);
                        return GestureDetector(
                          onTap: () {
                            _onPressed(index);
                            selectedScreen.changeScreen(selection[item]);
                          },
                          child: SizedBox(
                            width: screenSize.width * 0.2,
                            child: TextButton(
                              onPressed: () {
                                _onPressed(index);
                                selectedScreen.changeScreen(selection[item]);
                              },
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: selectionIsPressed.map((isPressed) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: screenSize.height * 0.001),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: screenSize.width * 0.2,
                            height: screenSize.height * 0.005,
                            color: isPressed
                                ? Theme.of(context).highlightColor
                                : Theme.of(context).scaffoldBackgroundColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            )
          : null,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  selectedScreen.changeScreen(Homepage(
                      scrollController: selectedScreen.scrollController));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.015),
                  child: Image.asset(
                    'assets/images/petshop_logo.png',
                    width: screenSize.width * 0.08,
                    height: screenSize.height * 0.12,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.05),
                    child: Text(
                      'FOFINHOS PETSHOP',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.82,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02),
                          child: const SearchBarPetShop(),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    accountIsPressed = true;
                                  });
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    accountIsPressed = false;
                                  });
                                },
                                onTapCancel: () {
                                  setState(() {
                                    accountIsPressed = false;
                                  });
                                },
                                child: IconButton(
                                  onPressed: () {
                                    print(accountIsPressed);
                                  },
                                  icon: Icon(
                                    Icons.person,
                                    color: accountIsPressed
                                        ? Colors.white
                                        : Theme.of(context).highlightColor,
                                    size: screenSize.height * 0.035,
                                  ),
                                  splashRadius: screenSize.height * 0.04,
                                ),
                              ),
                              GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    contactIsPressed = true;
                                  });
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    contactIsPressed = false;
                                  });
                                },
                                onTapCancel: () {
                                  setState(() {
                                    contactIsPressed = false;
                                  });
                                },
                                child: IconButton(
                                  onPressed: () {
                                    selectedScreen
                                        .changeScreen(const ContactPage());
                                  },
                                  icon: Icon(
                                    Icons.phone_enabled_rounded,
                                    color: contactIsPressed
                                        ? Colors.white
                                        : Theme.of(context).highlightColor,
                                    size: screenSize.height * 0.035,
                                  ),
                                  splashRadius: screenSize.height * 0.04,
                                ),
                              ),
                              GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    cartIsPressed = true;
                                  });
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    cartIsPressed = false;
                                  });
                                },
                                onTapCancel: () {
                                  setState(() {
                                    cartIsPressed = false;
                                  });
                                },
                                child: IconButton(
                                  onPressed: () {
                                    selectedScreen.scaffoldKey.currentState
                                        ?.openEndDrawer();
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart_rounded,
                                    color: cartIsPressed
                                        ? Colors.white
                                        : Theme.of(context).highlightColor,
                                    size: screenSize.height * 0.035,
                                  ),
                                  splashRadius: screenSize.height * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
