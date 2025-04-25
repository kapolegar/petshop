import 'package:flutter/material.dart';
import 'package:petshop/components/appbar_components/appbar.dart';
import 'package:petshop/providers/products_provider.dart';
import 'package:petshop/screens/contact.dart';
import '../components/cart_components/shopping_cart.dart';
import '../providers/selected_screen_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;

  const Home({super.key, required this.child, required this.scrollController});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showBottom = true;
  late SelectScreen selectedScreen;
  final List<Type> telasSemBottom = [ContactPage];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedScreen = Provider.of<SelectScreen>(context, listen: false);

    loadData();

    widget.scrollController.addListener(() {
      if (selectedScreen.scrollController.offset > 100 && showBottom) {
        setState(() => showBottom = false);
      } else if (selectedScreen.scrollController.offset <= 100 && !showBottom) {
        setState(() => showBottom = true);
      }
    });
  }

  Future<void> loadData() async {
    final productsProvider = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );
    await productsProvider.loadProducts();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isOnHiddenScreen = telasSemBottom.contains(
      selectedScreen.selectedScreenType,
    );

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Consumer<SelectScreen>(
      builder: (context, cart, child) {
        return Scaffold(
          key: selectedScreen.scaffoldKey,
          appBar:
              selectedScreen.noAppBarScreens.contains(
                    selectedScreen.selectedScreenType,
                  )
                  ? null
                  : PreferredSize(
                    preferredSize:
                        (showBottom && !isOnHiddenScreen)
                            ? Size.fromHeight(screenSize.height * 0.25)
                            : Size.fromHeight(screenSize.height * 0.2),
                    child: AppBarPetShop(
                      showBottom: showBottom,
                      isOnHiddenScreen: isOnHiddenScreen,
                      scrollController: selectedScreen.scrollController,
                    ),
                  ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: widget.child,
          endDrawer: const ShoppingCart(),
        );
      },
    );
  }
}
