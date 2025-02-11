import 'package:flutter/material.dart';
import 'package:petshop/components/appbar_components/appbar.dart';
import 'package:petshop/screens/contact.dart';
import '../components/shopping_cart.dart';
import '../providers/selected_screen_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showBottom = true;
  late SelectScreen selectedScreen;
  final List<Type> telasSemBottom = [ContactPage];

  @override
  void initState() {
    selectedScreen = Provider.of<SelectScreen>(context, listen: false);

    selectedScreen.scrollController.addListener(() {
      if (selectedScreen.scrollController.offset > 100 && showBottom) {
        setState(() => showBottom = false);
      } else if (selectedScreen.scrollController.offset <= 100 && !showBottom) {
        setState(() => showBottom = true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isOnHiddenScreen =
        telasSemBottom.contains(selectedScreen.selectedScreen.runtimeType);

    return Scaffold(
      key: selectedScreen.scaffoldKey,
      appBar: PreferredSize(
        preferredSize: (showBottom && !isOnHiddenScreen)
            ? Size.fromHeight(screenSize.height * 0.27)
            : Size.fromHeight(screenSize.height * 0.22),
        child: AppBarPetShop(
          showBottom: showBottom,
          isOnHiddenScreen: isOnHiddenScreen,
          scrollController: selectedScreen.scrollController,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<SelectScreen>(
        builder: (context, cart, child) {
          return selectedScreen.selectedScreen;
        },
      ),
      endDrawer: ShoppingCart(),
    );
  }
}
