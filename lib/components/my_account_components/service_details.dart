import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/models/service.dart';
import 'package:petshop/models/pets_infos.dart';
import 'package:petshop/providers/services_provider.dart';
import 'package:petshop/providers/my_account_provider.dart';

class ServiceDetails extends StatefulWidget {
  final PetService service;
  const ServiceDetails({required this.service, super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );

    Services servicesProvider = Provider.of<Services>(context, listen: false);

    PetsInfos pet = myAccountProvider.userPets.firstWhere(
      (pet) => pet.id == int.parse(widget.service.petID),
    );
    String itemService =
        servicesProvider.servicesList.entries
            .firstWhere(
              (element) => element.value == int.parse(widget.service.id),
            )
            .key;
    String serviceStatus =
        servicesProvider.servicesStatusList.entries
            .firstWhere(
              (element) => element.value == int.parse(widget.service.status),
            )
            .key;

    return AnimatedContainer(
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
            'Detalhes do Serviço nº ${widget.service.id.toString()}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: screenSize.height * 0.025),
          Text('Solicitado em ${widget.service.dataSolicitacao}'),
          SizedBox(height: screenSize.height * 0.05),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.2,
                width: screenSize.height * 0.2,
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
              SizedBox(width: screenSize.width * 0.02),
              Column(
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
                  SizedBox(height: screenSize.height * 0.015),
                  RichText(
                    text: TextSpan(
                      text: 'Data do agendamento: ',
                      style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        fontSize: screenSize.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(187, 0, 0, 0),
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${widget.service.data} às ${widget.service.hora}',
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
                      text: 'Status: ',
                      style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        fontSize: screenSize.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(187, 0, 0, 0),
                      ),
                      children: [
                        TextSpan(
                          text: serviceStatus,
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
                  SizedBox(
                    width: screenSize.width * 0.45,
                    child: RichText(
                      text: TextSpan(
                        text: 'Observações informadas: ',
                        style: TextStyle(
                          fontFamily: 'NunitoSansBold',
                          fontSize: screenSize.height * 0.018,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(187, 0, 0, 0),
                        ),
                        children: [
                          TextSpan(
                            text: widget.service.observacoes,
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
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
