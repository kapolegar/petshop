import 'package:flutter/material.dart';
import 'package:petshop/screens/home.dart';
import 'package:petshop/screens/login.dart';
import 'package:petshop/models/product.dart';
import 'package:petshop/screens/buy_cart.dart';
import 'package:petshop/screens/pay_cart.dart';
import 'package:petshop/components/my_account_components/create_new_account.dart';

class SelectScreen extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  final List<Type> _noAppBarScreens = [
    CreateNewAccount,
    Login,
    BuyCart,
    PayCart,
  ];
  String _bottomBarMenuSelection = '';
  bool _isHoveringOptions = false;

  late Widget _selectedScreen = Home(
    scrollController: _scrollController,
    child: const SizedBox(),
  );
  late Type _selectedScreenType =
      Home(
        scrollController: _scrollController,
        child: const SizedBox(),
      ).runtimeType;

  List<String> _routes = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> get routes => _routes;
  Widget get selectedScreen => _selectedScreen;
  bool get isHoveringOptions => _isHoveringOptions;
  Type get selectedScreenType => _selectedScreenType;
  List<Type> get noAppBarScreens => _noAppBarScreens;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  ScrollController get scrollController => _scrollController;
  String get bottomBarMenuSelection => _bottomBarMenuSelection;

  void updateHovering(bool value) {
    if (_isHoveringOptions != value) {
      _isHoveringOptions = value;
      notifyListeners();
    }
  }

  void updateBottomBarMenuSelection(String selectedItem) {
    _bottomBarMenuSelection = selectedItem;
    notifyListeners();
  }

  void changeScreen(Widget screen) {
    _selectedScreen = screen;
    _selectedScreenType = screen.runtimeType;
    notifyListeners();
  }

  void clearRoutes() {
    _routes.clear();
    notifyListeners();
  }

  void addRoute(String route) {
    if (!_routes.contains(route)) {
      _routes.add(route);
      notifyListeners();
    }
  }

  void goToRoute(BuildContext context, String route, Product product) {
    int index = _routes.indexOf(route);
    _routes = _routes.sublist(0, index + 1);
    notifyListeners();
  }
}
