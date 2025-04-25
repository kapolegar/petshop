import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/components/my_account_components/edit_pets_card.dart';
import 'package:petshop/components/my_account_components/my_credit_cards.dart';
import 'package:petshop/components/my_account_components/services_history.dart';
import 'package:petshop/components/my_account_components/shopping_history.dart';
import 'package:petshop/components/my_account_components/edit_account_info_card.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  bool showBottom = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.white,
      child: Consumer<MyAccount>(
        builder:
            (_, myAccountProvider, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.05),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenSize.width * 0.075,
                        right: screenSize.width * 0.025,
                        top: screenSize.height * 0.03,
                        bottom: screenSize.height * 0.06,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenSize.height * 0.02,
                            ),
                            child: Text(
                              'Olá, ${myAccountProvider.loggedUserInfos!.nome.split(' ')[0]}!',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: const Color.fromRGBO(227, 28, 70, 1),
                                    size: screenSize.height * 0.04,
                                  ),
                                  SizedBox(width: screenSize.width * 0.02),
                                  Text(
                                    'Editar Informações da Conta',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold',
                                      fontSize: screenSize.height * 0.018,
                                      letterSpacing: screenSize.width * 0.0001,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: const Color.fromARGB(
                                        255,
                                        227,
                                        28,
                                        71,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed:
                                  () => myAccountProvider
                                      .updateAccountDetailsScreen(
                                        const EditAccountInfo(),
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.pets_rounded,
                                    color: const Color.fromRGBO(227, 28, 70, 1),
                                    size: screenSize.height * 0.04,
                                  ),
                                  SizedBox(width: screenSize.width * 0.02),
                                  Text(
                                    'Cadastrar / Editar Pets',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold',
                                      fontSize: screenSize.height * 0.018,
                                      letterSpacing: screenSize.width * 0.0001,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: const Color.fromARGB(
                                        255,
                                        227,
                                        28,
                                        71,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed:
                                  () => myAccountProvider
                                      .updateAccountDetailsScreen(
                                        const EditPets(),
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart_rounded,
                                    color: const Color.fromRGBO(227, 28, 70, 1),
                                    size: screenSize.height * 0.04,
                                  ),
                                  SizedBox(width: screenSize.width * 0.02),
                                  Text(
                                    'Histórico de Compras',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold',
                                      fontSize: screenSize.height * 0.018,
                                      letterSpacing: screenSize.width * 0.0001,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: const Color.fromARGB(
                                        255,
                                        227,
                                        28,
                                        71,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed:
                                  () => myAccountProvider
                                      .updateAccountDetailsScreen(
                                        const ShoppingHistory(),
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: const Color.fromRGBO(227, 28, 70, 1),
                                    size: screenSize.height * 0.04,
                                  ),
                                  SizedBox(width: screenSize.width * 0.02),
                                  Text(
                                    'Histórico de Serviços',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold',
                                      fontSize: screenSize.height * 0.018,
                                      letterSpacing: screenSize.width * 0.0001,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: const Color.fromARGB(
                                        255,
                                        227,
                                        28,
                                        71,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed:
                                  () => myAccountProvider
                                      .updateAccountDetailsScreen(
                                        const ServicesHistory(),
                                      ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.credit_card,
                                    color: const Color.fromRGBO(227, 28, 70, 1),
                                    size: screenSize.height * 0.04,
                                  ),
                                  SizedBox(width: screenSize.width * 0.02),
                                  Text(
                                    'Meus Cartões',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold',
                                      fontSize: screenSize.height * 0.018,
                                      letterSpacing: screenSize.width * 0.0001,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: const Color.fromARGB(
                                        255,
                                        227,
                                        28,
                                        71,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed:
                                  () => myAccountProvider
                                      .updateAccountDetailsScreen(
                                        const MyCreditCards(),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: screenSize.height * 0.65,
                        padding: EdgeInsets.only(
                          right: screenSize.width * 0.075,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [myAccountProvider.accountDetailsScreen],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
