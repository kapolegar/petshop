import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/components/services_components/banho_e_tosa.dart';
import 'package:petshop/components/services_components/consulta_veterinaria.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late String _selectedService;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> options = [
    {
      'Title': 'Banho e / ou Tosa   ',
      'Icon': Icons.bubble_chart_rounded,
      'Description':
          'Rutrum ornare porta per turpis mauris mattis ligula sagittis. Habitasse eget quisque id luctus et donec scelerisque proin commodo. Sed et ut phasellus pulvinar ultricies fermentum. Porttitor amet accumsan suscipit habitant risus facilisi orci. Imperdiet at in quam sollicitudin finibus; non lorem. Porta purus donec integer penatibus molestie lacus; posuere ultricies. Massa scelerisque elementum hac nulla praesent dolor dui. Vivamus hac primis netus sollicitudin neque ut luctus ipsum. Aenean sociosqu facilisis risus penatibus; quisque aenean pellentesque.',
      'Page': const BanhoETosa(),
    },
    {
      'Title': 'Consulta Veterinária',
      'Icon': Icons.pets_rounded,
      'Description':
          'Lorem ipsum odor amet, consectetuer adipiscing elit. Habitant nascetur dignissim praesent nisl finibus aptent et. Ut non tristique efficitur diam a amet. Adipiscing faucibus feugiat condimentum sem mauris aptent aliquam fames. Amet vulputate placerat a venenatis ridiculus sollicitudin. Ultrices dignissim orci platea curae phasellus, venenatis ultrices. Morbi fermentum eget pulvinar diam hendrerit, fermentum vitae pharetra. Habitasse ipsum lobortis at, netus dignissim maximus nulla sed? Integer maecenas pulvinar aliquam amet in ligula pretium primis tristique. Nisl condimentum et potenti proin elit a justo magna blandit.',
      'Page': const ConsultaVeterinaria(),
    },
  ];

  _onPressed(MyAccount myAccountProvider, SelectScreen selectScreenProvider) {
    myAccountProvider.loggedUserInfos == null
        ? context.goNamed(
          'login',
          extra: {'fromScreen': ServicesPage, 'orderID': ''},
        )
        : showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return options.firstWhere(
              (element) => element['Title'] == _selectedService,
            )['Page'];
          },
        );
  }

  @override
  void initState() {
    _selectedService = options.first['Title'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );
    SelectScreen selectedScreen = Provider.of<SelectScreen>(
      context,
      listen: false,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.075),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    options.map((element) {
                      return Padding(
                        padding: EdgeInsets.all(screenSize.height * 0.03),
                        child: ElevatedButton(
                          onPressed:
                              _selectedService == element['Title']
                                  ? null
                                  : () {
                                    setState(() {
                                      _selectedService = element['Title'];
                                    });
                                  },
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      screenSize.height * 0.02,
                                    ),
                                  ),
                                ),
                            backgroundColor:
                                _selectedService == element['Title']
                                    ? WidgetStateProperty.all<Color>(
                                      Theme.of(context).dividerColor,
                                    )
                                    : WidgetStateProperty.all<Color>(
                                      Theme.of(context).primaryColorDark,
                                    ),
                            overlayColor: WidgetStateProperty.all<Color>(
                              Colors.transparent,
                            ),
                          ),
                          child: Container(
                            height: screenSize.height * 0.08,
                            width: screenSize.width * 0.16,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: screenSize.width * 0.01,
                                    ),
                                    child: Icon(
                                      element['Icon'],
                                      color: Colors.white,
                                      size: screenSize.height * 0.05,
                                    ),
                                  ),
                                  Text(
                                    element['Title'],
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold',
                                      fontSize: screenSize.height * 0.02,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: screenSize.width * 0.0001,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: screenSize.height * 0.07),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1,
                ),
                child: Text(
                  'Descrição do serviço',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: screenSize.width * 0.1),
                  SizedBox(
                    width: screenSize.width * 0.5,
                    child: Text(
                      options.firstWhere(
                        (element) => element['Title'] == _selectedService,
                      )['Description'],
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: screenSize.height * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.05),
                  ElevatedButton(
                    onPressed:
                        () => _onPressed(myAccountProvider, selectedScreen),
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenSize.height * 0.02,
                          ),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).primaryColorDark,
                      ),
                      overlayColor: WidgetStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                    ),
                    child: Container(
                      height: screenSize.height * 0.06,
                      width: screenSize.width * 0.09,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.white,
                              size: screenSize.height * 0.04,
                            ),
                            Text(
                              'Agendar',
                              style: TextStyle(
                                fontFamily: 'NunitoSansBold',
                                fontSize: screenSize.height * 0.02,
                                fontWeight: FontWeight.bold,
                                letterSpacing: screenSize.width * 0.0001,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
