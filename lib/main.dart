import 'package:flutter/material.dart';
import 'package:petshop/screens/home.dart';
import 'package:provider/provider.dart';
import 'providers/selected_screen_provider.dart';
import 'screens/homepage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SelectScreen(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'PetShop',
      theme: ThemeData(
        // Cores principais
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        primaryColor: Color.fromARGB(255, 21, 202, 163),
        highlightColor: const Color.fromRGBO(227, 28, 70, 1),
        hoverColor: const Color.fromARGB(27, 227, 28, 71),
        dividerColor: Color.fromARGB(79, 227, 28, 71),

        // Configuração do TextTheme
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

        // Outras configurações de tema
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
          thumbVisibility: MaterialStateProperty.all(true),
          thumbColor:
              MaterialStateProperty.all(const Color.fromRGBO(28, 227, 185, 1)),
          trackColor:
              MaterialStateProperty.all(const Color.fromRGBO(255, 255, 255, 1)),
          thickness: MaterialStateProperty.all(screenSize.height * 0.0075),
          // radius: Radius.circular(10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
            surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
      ),
      home: const Home(),
    );
  }
}
