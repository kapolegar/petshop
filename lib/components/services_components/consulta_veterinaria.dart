import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/models/service.dart';
import 'package:petshop/models/pets_infos.dart';
import 'package:petshop/providers/services_provider.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/models/consulta_veterinaria.schedule.dart';
import 'package:petshop/components/my_account_components/new_pet_dialog.dart';
import 'package:petshop/components/my_account_components/service_details.dart';

class ConsultaVeterinaria extends StatefulWidget {
  const ConsultaVeterinaria({super.key});

  @override
  State<ConsultaVeterinaria> createState() => _ConsultaVeterinariaState();
}

class _ConsultaVeterinariaState extends State<ConsultaVeterinaria> {
  int _selectedIndex = 0;
  String? _selectedHorario;
  final int _servicoSelecionado = 3;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _observacoesController = TextEditingController();

  Future<void> _selectDate(BuildContext context, Size screenSize) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd/MM/yyyy').parse(_dateController.text),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColorDark,
              onSurface: Colors.black,
              onSurfaceVariant: Theme.of(context).primaryColorDark,
            ),
            primaryColor: const Color.fromARGB(255, 21, 202, 163),
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            primaryColorDark: Colors.transparent,
            dividerTheme: DividerThemeData(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              insetPadding: const EdgeInsets.all(20.0),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                shadowColor: Theme.of(context).dividerColor,
                surfaceTintColor: Theme.of(context).dividerColor,
                overlayColor: Theme.of(context).dividerColor,
                foregroundColor: Theme.of(context).primaryColorDark,
              ),
            ),
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.03,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(227, 28, 70, 1),
              ),
              titleLarge: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.016,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titleSmall: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.016,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              bodyLarge: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: screenSize.height * 0.016,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              labelLarge: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.016,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String dataFormatada = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        _dateController.text = dataFormatada;
      });
    }
  }

  List<Widget> _petsList(List<PetsInfos> pets, Size screenSize) {
    List<Widget> petsList = [];

    for (int i = 0; i < pets.length; i++) {
      petsList.add(
        Padding(
          padding: EdgeInsets.only(right: screenSize.width * 0.01),
          child: Column(
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
                      onTap:
                          _selectedIndex == i
                              ? null
                              : () {
                                setState(() {
                                  _selectedIndex = i;
                                });
                              },
                      borderRadius: BorderRadius.circular(
                        screenSize.height * 0.008,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          pets[i].imagem == null
                              ? Icon(
                                Icons.pets,
                                size: screenSize.height * 0.04,
                                color: Theme.of(context).primaryColorDark,
                              )
                              : Ink.image(
                                image: MemoryImage(pets[i].imagem!),
                                fit: BoxFit.cover,
                              ),
                          if (_selectedIndex == i)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColorDark,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(
                                  screenSize.height * 0.008,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Text(
                pets[i].nome,
                style:
                    _selectedIndex == i
                        ? TextStyle(
                          fontFamily: 'NunitoSansBold',
                          fontSize: screenSize.height * 0.016,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark,
                        )
                        : TextStyle(
                          fontFamily: 'NunitoSans',
                          fontSize: screenSize.height * 0.016,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
              ),
            ],
          ),
        ),
      );
    }

    petsList.add(
      ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const NewPet();
            },
          );
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenSize.height * 0.02),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            Theme.of(context).primaryColor,
          ),
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        ),
        child: Container(
          height: screenSize.height * 0.08,
          width: screenSize.width * 0.02,
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: screenSize.height * 0.03,
          ),
        ),
      ),
    );

    return petsList;
  }

  List<Widget> _buildHorarioContainers(Size screenSize) {
    Provider.of<Services>(
      context,
      listen: false,
    ).getConsultaVeterinariaSchedules();
    DateTime selectedDate = DateFormat(
      'dd/MM/yyyy',
    ).parse(_dateController.text);
    Services servicesProvider = Provider.of<Services>(context, listen: false);

    List<String> horariosDisponiveis =
        servicesProvider.horariosConsultaVeterinariaDisponiveis
            .where((entry) => entry.pet == '' && entry.day == selectedDate)
            .map((entry) => entry.schedule)
            .toList();

    return horariosDisponiveis.map((horario) {
      return ElevatedButton(
        onPressed:
            _selectedHorario == horario
                ? null
                : () {
                  setState(() {
                    _selectedHorario = horario;
                  });
                },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            _selectedHorario == horario
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).dividerColor,
          ),
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.height * 0.01),
          child: Text(
            horario,
            style: TextStyle(
              fontFamily: 'NunitoSansBold',
              fontSize: screenSize.height * 0.018,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  _onSave(
    List<Map<String, dynamic>> pets,
    Services servicesProvider,
    SelectScreen selectScreenProvider,
    MyAccount myAccountProvider,
  ) {
    if (_selectedHorario != null && _dateController.text.isNotEmpty) {
      Services servicesProvider = Provider.of<Services>(context, listen: false);

      DateTime selectedDate = DateFormat(
        'dd/MM/yyyy',
      ).parse(_dateController.text);

      ConsultaVeterinariaSchedule newSchedule = ConsultaVeterinariaSchedule(
        day: selectedDate,
        schedule: _selectedHorario!,
        pet: pets[_selectedIndex]['Nome']!,
        obs: _observacoesController.text,
      );
      PetService newPetService = PetService(
        id: (servicesProvider.services.length + 1).toString(),
        servico: _servicoSelecionado,
        petID: pets[_selectedIndex]['ID'].toString(),
        dataSolicitacao: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        data: DateFormat('dd/MM/yyyy').format(selectedDate),
        hora: _selectedHorario!,
        status: '0',
        observacoes: _observacoesController.text,
      );

      servicesProvider.updateConsultaVeterinariaSchedule(newSchedule);

      servicesProvider.addToServices(newPetService);
      myAccountProvider.updateAccountDetailsScreen(
        ServiceDetails(service: newPetService),
      );
      context.goNamed('minha-conta');
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );

    SelectScreen selectScreenProvider = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    Services servicesProvider = Provider.of<Services>(context, listen: false);
    List<Map<String, String?>> pets =
        myAccountProvider.userPets.map((pet) => pet.toMap()).toList();

    return Consumer<MyAccount>(
      builder:
          (_, myAccount, __) => AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenSize.height * 0.02),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.height * 0.03,
                vertical: screenSize.height * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    "Agendamento de consulta veterinária",
                    style: TextStyle(
                      fontFamily: 'NunitoSansBold',
                      fontSize: screenSize.height * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            ),
            content: SizedBox(
              width: screenSize.width * 0.5,
              height: screenSize.height * 0.4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.height * 0.05,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Selecione o pet que irá receber o serviço',
                        style: TextStyle(
                          fontFamily: 'NunitoSansBold',
                          fontSize: screenSize.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _petsList(
                          myAccountProvider.userPets,
                          screenSize,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenSize.height * 0.02),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: screenSize.height * 0.02,
                            ),
                            child: Text(
                              'Informações do pet',
                              style: TextStyle(
                                fontFamily: 'NunitoSansBold',
                                fontSize: screenSize.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:
                                    pets[_selectedIndex].keys.toList().map((
                                      element,
                                    ) {
                                      return Text(
                                        element,
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontSize: screenSize.height * 0.018,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      );
                                    }).toList(),
                              ),
                              SizedBox(width: screenSize.width * 0.015),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:
                                    pets[_selectedIndex].values.toList().map((
                                      element,
                                    ) {
                                      return Text(
                                        element ?? '',
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontSize: screenSize.height * 0.018,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(
                                                context,
                                              ).primaryColorDark,
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      Text(
                        'Informe a data do serviço',
                        style: TextStyle(
                          fontFamily: 'NunitoSansBold',
                          fontSize: screenSize.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      SizedBox(
                        width: screenSize.width * 0.1,
                        height: screenSize.height * 0.075,
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontSize: screenSize.height * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.calendar_month_rounded,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 1,
                              ),
                            ),
                          ),
                          onTap: () => _selectDate(context, screenSize),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Text(
                        'Horários disponíveis',
                        style: TextStyle(
                          fontFamily: 'NunitoSansBold',
                          fontSize: screenSize.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Wrap(
                        spacing: screenSize.width * 0.005,
                        runSpacing: screenSize.width * 0.005,
                        children: _buildHorarioContainers(screenSize),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Text(
                        'Observações Adicionais',
                        style: TextStyle(
                          fontFamily: 'NunitoSansBold',
                          fontSize: screenSize.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Padding(
                        padding: EdgeInsets.only(
                          right: screenSize.height * 0.02,
                        ),
                        child: Container(
                          height: screenSize.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              screenSize.height * 0.02,
                            ),
                            color: const Color.fromARGB(255, 238, 238, 238),
                          ),
                          padding: EdgeInsets.all(screenSize.height * 0.02),
                          child: TextFormField(
                            controller: _observacoesController,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(
                                screenSize.height * 0.02,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: screenSize.height * 0.018,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(screenSize.height * 0.04),
                child: TextButton(
                  onPressed: () {
                    _onSave(
                      pets,
                      servicesProvider,
                      selectScreenProvider,
                      myAccountProvider,
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Salvar",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
