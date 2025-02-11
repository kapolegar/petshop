import 'package:flutter/material.dart';
import 'package:petshop/screens/homepage.dart';
import 'package:petshop/screens/product_details.dart';
import 'package:petshop/screens/products.dart';

class SelectScreen extends ChangeNotifier {
  ScrollController _scrollController = ScrollController();
  late Widget _selectedScreen = Homepage(
    scrollController: _scrollController,
  );
  List<String> _routes = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> get routes => _routes;
  Widget get selectedScreen => _selectedScreen;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  ScrollController get scrollController => _scrollController;

  void changeScreen(Widget screen) {
    _selectedScreen = screen;
    notifyListeners();
  }

  void addRoute(String route) {
    if (!_routes.contains(route)) {
      _routes.add(route);
      notifyListeners();
    }
  }

  void goToRoute(BuildContext context, String route) {
    int index = _routes.indexOf(route);
    _routes = _routes.sublist(0, index + 1);

    if (route == "Home") {
      _selectedScreen = Homepage(
        scrollController: _scrollController,
      );
    } else if (route == "Produtos") {
      _selectedScreen = ProductsPage();
    } else if (route == 'Exemplo Produto') {
      _selectedScreen = ProductDetails(
        image: 'images/products/racao_gato1.jpg',
      );
    }
    notifyListeners();
  }
}
