import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/selected_screen_provider.dart';

class NavigationBreadcrumb extends StatefulWidget {
  const NavigationBreadcrumb({super.key});

  @override
  State<NavigationBreadcrumb> createState() => _NavigationBreadcrumbState();
}

class _NavigationBreadcrumbState extends State<NavigationBreadcrumb> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var navTracker = Provider.of<SelectScreen>(context);

    return Padding(
      padding: EdgeInsets.only(top: screenSize.height * 0.03),
      child: Wrap(
        spacing: screenSize.width * 0.005,
        alignment: WrapAlignment.center,
        children: List.generate(
          navTracker.routes.length * 2 - 1,
          (index) {
            if (index.isEven) {
              // Cria o botão de navegação
              int routeIndex = index ~/ 2;
              return ElevatedButton(
                onPressed: () {
                  navTracker.goToRoute(context, navTracker.routes[routeIndex]);
                },
                child: Text(
                  navTracker.routes[routeIndex],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            } else {
              // Adiciona o separador ">" entre os itens
              return Icon(Icons.arrow_right_sharp);
            }
          },
        ),
      ),
    );
  }
}
