import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/models/product.dart';
import '../providers/selected_screen_provider.dart';

class NavigationBreadcrumb extends StatefulWidget {
  final Product product;
  const NavigationBreadcrumb({required this.product, super.key});

  @override
  State<NavigationBreadcrumb> createState() => _NavigationBreadcrumbState();
}

class _NavigationBreadcrumbState extends State<NavigationBreadcrumb> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SelectScreen navTracker = Provider.of<SelectScreen>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.02,
        horizontal: screenSize.width * 0.075,
      ),
      child: Wrap(
        spacing: screenSize.width * 0.005,
        alignment: WrapAlignment.center,
        children: List.generate(navTracker.routes.length * 2 - 1, (index) {
          if (index.isEven) {
            int routeIndex = index ~/ 2;
            return ElevatedButton(
              onPressed: () {
                navTracker.goToRoute(
                  context,
                  navTracker.routes[routeIndex],
                  widget.product,
                );
              },
              child: Text(
                navTracker.routes[routeIndex],
                style: TextStyle(
                  fontFamily: 'NunitoSansBold',
                  fontSize: screenSize.height * 0.018,
                  fontWeight: FontWeight.bold,
                  letterSpacing: screenSize.width * 0.0001,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            );
          } else {
            return Icon(
              Icons.arrow_right_sharp,
              color: Theme.of(context).primaryColorDark,
            );
          }
        }),
      ),
    );
  }
}
