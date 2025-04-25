import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/screens/home.dart';
import 'package:petshop/screens/login.dart';
import 'package:petshop/models/product.dart';
import 'package:petshop/screens/contact.dart';
import 'package:petshop/screens/buy_cart.dart';
import 'package:petshop/screens/pay_cart.dart';
import 'package:petshop/screens/services.dart';
import 'package:petshop/screens/myaccount.dart';
import 'package:petshop/screens/product_details.dart';
import 'package:petshop/screens/home_products_page.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/components/my_account_components/create_new_account.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final scrollController =
              Provider.of<SelectScreen>(
                context,
                listen: false,
              ).scrollController;

          return Home(scrollController: scrollController, child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) {
              final scrollController =
                  Provider.of<SelectScreen>(
                    context,
                    listen: false,
                  ).scrollController;

              return HomeProductsPage(scrollController: scrollController);
            },
          ),
          GoRoute(
            path: '/contato',
            name: 'contato',
            builder: (context, state) => const ContactPage(),
          ),
          GoRoute(
            path: '/servicos',
            name: 'servicos',
            builder: (context, state) => const ServicesPage(),
          ),
          GoRoute(
            path: '/produtos',
            name: 'produtos',
            builder: (context, state) {
              final scrollController =
                  Provider.of<SelectScreen>(
                    context,
                    listen: false,
                  ).scrollController;

              final filters = state.uri.queryParametersAll['filtro'] ?? [];

              return HomeProductsPage(
                scrollController: scrollController,
                filteredItems: filters,
              );
            },
          ),
          GoRoute(
            path: '/produtos/detalhes-produto/:productName',
            name: 'detalhesProduto',
            builder: (context, state) {
              final product = state.extra as Product;
              final filtros = state.uri.queryParametersAll['filtro'] ?? [];

              return ProductDetails(product: product);
            },
          ),
          GoRoute(
            path: '/minha-conta',
            name: 'minha-conta',
            builder: (context, state) {
              return const MyAccountPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          final fromScreen =
              state.extra != null && state.extra is Map
                  ? (state.extra as Map)['fromScreen'] as Type
                  : Object;
          final orderID =
              state.extra != null && state.extra is Map
                  ? (state.extra as Map)['orderID'] as String
                  : '';

          return Login(fromScreen: fromScreen, orderID: orderID);
        },
      ),
      GoRoute(
        path: '/criar-conta',
        name: 'criar-conta',
        builder: (context, state) {
          final fromScreen =
              state.extra != null && state.extra is Map
                  ? (state.extra as Map)['fromScreen'] as Type
                  : Object;
          final orderID =
              state.extra != null && state.extra is Map
                  ? (state.extra as Map)['orderID'] as String
                  : '';

          return CreateNewAccount(fromScreen: fromScreen, orderID: orderID);
        },
      ),
      GoRoute(
        path: '/carrinho',
        name: 'carrinho',
        builder: (context, state) {
          return const BuyCart();
        },
      ),
      GoRoute(
        path: '/carrinho/pagamento/pedido-:orderID',
        name: 'pagamento',
        builder: (context, state) {
          final orderID = state.pathParameters['orderID']!;
          return PayCart(orderID: orderID);
        },
      ),
    ],
  );
}
