import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/app_routes.dart';
import 'providers/selected_screen_provider.dart';
import 'package:petshop/providers/products_provider.dart';
import 'package:petshop/providers/services_provider.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/order_history_provider.dart';
import 'package:petshop/providers/shopping_cart_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectScreen>(
          create: (context) => SelectScreen(),
        ),
        ChangeNotifierProvider<Services>(create: (context) => Services()),
        ChangeNotifierProvider<MyAccount>(create: (context) => MyAccount()),
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider<ShoppingCartProvider>(
          create: (context) => ShoppingCartProvider(),
        ),
        ChangeNotifierProvider<OrderHistoryProvider>(
          create: (context) => OrderHistoryProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MaterialApp.router(
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      title: 'PetShop',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        primaryColor: const Color.fromARGB(255, 21, 202, 163),
        primaryColorDark: const Color.fromRGBO(227, 28, 70, 1),
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        dividerColor: const Color.fromARGB(79, 227, 28, 71),
        splashColor: Colors.transparent,

        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'NunitoSansBold',
            fontSize: screenSize.height * 0.035,
            fontWeight: FontWeight.w900,
            color: const Color.fromRGBO(227, 28, 70, 1),
          ),
          bodyLarge: TextStyle(
            fontFamily: 'NunitoSansBold',
            fontSize: screenSize.height * 0.024,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(227, 28, 70, 1),
          ),
          bodyMedium: TextStyle(
            fontFamily: 'NunitoSansBold',
            fontSize: screenSize.height * 0.018,
            fontWeight: FontWeight.bold,
            letterSpacing: screenSize.width * 0.0001,
            color: const Color.fromARGB(187, 0, 0, 0),
          ),
          bodySmall: TextStyle(
            fontFamily: 'NunitoSansBold',
            fontSize: screenSize.height * 0.022,
            fontWeight: FontWeight.bold,
            letterSpacing: screenSize.width * 0.0001,
            color: const Color.fromRGBO(227, 28, 70, 1),
          ),
          labelSmall: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: screenSize.height * 0.018,
            letterSpacing: screenSize.width * 0.0001,
            fontWeight: FontWeight.bold,
            height: screenSize.height * 0.003,
            color: const Color.fromARGB(144, 227, 28, 71),
          ),
          labelMedium: TextStyle(
            fontFamily: 'NunitoSansBold',
            fontSize: screenSize.height * 0.022,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            fontFamily: 'NunitoSansBold',
            fontSize: screenSize.height * 0.027,
            fontWeight: FontWeight.bold,
            letterSpacing: screenSize.width * 0.0001,
            color: const Color.fromARGB(187, 0, 0, 0),
          ),
        ),

        appBarTheme: AppBarTheme(
          toolbarHeight: screenSize.height * 0.2,
          color: const Color.fromRGBO(255, 255, 255, 1),
          titleTextStyle: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: screenSize.height * 0.035,
            fontWeight: FontWeight.w800,
            color: const Color.fromRGBO(227, 28, 70, 1),
          ),
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStateProperty.all(true),
          thumbColor: WidgetStateProperty.all(
            const Color.fromRGBO(28, 227, 185, 1),
          ),
          trackColor: WidgetStateProperty.all(
            const Color.fromRGBO(255, 255, 255, 1),
          ),
          thickness: WidgetStateProperty.all(screenSize.height * 0.0075),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            elevation: WidgetStateProperty.all(0),
            surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            shadowColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
      ),
    );
  }
}
