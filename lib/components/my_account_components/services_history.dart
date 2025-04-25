import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/models/service.dart';
import 'package:petshop/models/pets_infos.dart';
import 'package:petshop/providers/services_provider.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/components/my_account_components/service_details.dart';

class ServicesHistory extends StatefulWidget {
  const ServicesHistory({super.key});

  @override
  State<ServicesHistory> createState() => _ServicesHistoryState();
}

class _ServicesHistoryState extends State<ServicesHistory> {
  DateTime? startDate;
  DateTime? endDate;

  Widget serviceItem(
    Size screenSize,
    PetService item,
    SelectScreen selectScreenProvider,
    MyAccount myAccountProvider,
    Services servicesProvider,
  ) {
    PetsInfos pet = myAccountProvider.userPets.firstWhere(
      (pet) => pet.id == int.parse(item.petID),
    );
    String itemService =
        servicesProvider.servicesList.entries
            .firstWhere((element) => element.value == item.servico)
            .key;
    String serviceStatus =
        servicesProvider.servicesStatusList.entries
            .firstWhere((element) => element.value == int.parse(item.status))
            .key;

    return InkWell(
      onTap:
          () => myAccountProvider.updateAccountDetailsScreen(
            ServiceDetails(service: item),
          ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: screenSize.height * 0.02,
          right: screenSize.width * 0.0155,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width * 0.185,

              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.01,
                vertical: screenSize.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenSize.height * 0.015),
                border: Border.all(color: Theme.of(context).primaryColorDark),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.08,
                    width: screenSize.height * 0.08,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        screenSize.height * 0.008,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: null,
                          borderRadius: BorderRadius.circular(
                            screenSize.height * 0.008,
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Ink.image(
                                image: MemoryImage(pet.imagem!),
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Pet: ',
                          style: TextStyle(
                            fontFamily: 'NunitoSansBold',
                            fontSize: screenSize.height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(187, 0, 0, 0),
                          ),
                          children: [
                            TextSpan(
                              text: pet.nome,
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: screenSize.height * 0.018,
                                fontWeight: FontWeight.bold,
                                letterSpacing: screenSize.width * 0.0001,
                                color: const Color.fromARGB(187, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      RichText(
                        text: TextSpan(
                          text: 'Serviço: ',
                          style: TextStyle(
                            fontFamily: 'NunitoSansBold',
                            fontSize: screenSize.height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(187, 0, 0, 0),
                          ),
                          children: [
                            TextSpan(
                              text: itemService,
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: screenSize.height * 0.018,
                                fontWeight: FontWeight.bold,
                                letterSpacing: screenSize.width * 0.0001,
                                color: const Color.fromARGB(187, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text('ID do Serviço: ${item.id}'),
            Text(item.data),
            Text('Status: $serviceStatus'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Services servicesProvider = Provider.of<Services>(context, listen: false);
    SelectScreen selectScreenProvider = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );

    return AnimatedContainer(
      width: screenSize.width * 0.6,
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(screenSize.height * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
        borderRadius: BorderRadius.circular(screenSize.height * 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meus Serviços e Consultas',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: screenSize.height * 0.03),
          Text(
            'Confira os detalhes dos seus serviços e consultas.',
            style: TextStyle(
              fontFamily: 'NunitoSansBold',
              fontSize: screenSize.height * 0.018,
              fontWeight: FontWeight.normal,
              letterSpacing: screenSize.width * 0.0001,
              color: const Color.fromARGB(187, 0, 0, 0),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              for (PetService item in servicesProvider.services)
                serviceItem(
                  screenSize,
                  item,
                  selectScreenProvider,
                  myAccountProvider,
                  servicesProvider,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
