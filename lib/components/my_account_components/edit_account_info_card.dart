import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/providers/my_account_provider.dart';

class EditAccountInfo extends StatefulWidget {
  const EditAccountInfo({super.key});

  @override
  State<EditAccountInfo> createState() => _EditAccountInfoState();
}

class _EditAccountInfoState extends State<EditAccountInfo> {
  bool _anyChanges = false;
  String? _selectedGender;
  final List<String> _options = ['Feminino', 'Masculino', 'Não Informar'];

  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeAdress = FocusNode();
  final FocusNode _focusNodeAdressDetails = FocusNode();
  final FocusNode _focusNodeNeighborhood = FocusNode();
  final FocusNode _focusNodePhone1 = FocusNode();
  final FocusNode _focusNodePhone1DDD = FocusNode();
  final FocusNode _focusNodePhone2 = FocusNode();
  final FocusNode _focusNodePhone2DDD = FocusNode();

  final Color _nameBorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _emailBorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _adressBorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _adressDetailsBorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _neighborhoodBorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _phone1BorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _phone1DDDBorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _phone2BorderColor = const Color.fromARGB(79, 227, 28, 71);
  final Color _phone2DDDBorderColor = const Color.fromARGB(79, 227, 28, 71);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _adressDetailsController =
      TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _phone1Controller = TextEditingController();
  final TextEditingController _phone1DDDController = TextEditingController();
  final TextEditingController _phone2Controller = TextEditingController();
  final TextEditingController _phone2DDDController = TextEditingController();

  Widget textFieldContainer(
    Size screenSize,
    double width,
    FocusNode focusNode,
    Color borderColor,
    TextEditingController controller,
  ) {
    return Container(
      width: width,
      height: screenSize.height * 0.05,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 0.75),
        borderRadius: BorderRadius.circular(screenSize.height * 0.015),
      ),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            _anyChanges = true;
          });
        },
        controller: controller,
        style: TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: screenSize.height * 0.018,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(190, 0, 0, 0),
        ),
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.01,
            vertical: screenSize.height * 0.01,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );
    _nameController.text = myAccountProvider.loggedUserInfos!.nome;
    _emailController.text = myAccountProvider.loggedUserInfos!.email;
    _adressController.text = myAccountProvider.loggedUserInfos!.endereco ?? '';
    _adressDetailsController.text =
        myAccountProvider.loggedUserInfos!.complemento ?? '';
    _neighborhoodController.text =
        myAccountProvider.loggedUserInfos!.bairro ?? '';
    _phone1DDDController.text =
        myAccountProvider.loggedUserInfos!.dddCelular ?? '';
    _phone1Controller.text = myAccountProvider.loggedUserInfos!.celular ?? '';
    _phone2DDDController.text =
        myAccountProvider.loggedUserInfos!.dddTelefoneFixo ?? '';
    _phone2Controller.text =
        myAccountProvider.loggedUserInfos!.telefoneFixo ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          Text('Meus Dados', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: screenSize.height * 0.03),
          Text(
            'Confira os detalhes dos seus dados.',
            style: TextStyle(
              fontFamily: 'NunitoSansBold',
              fontSize: screenSize.height * 0.018,
              fontWeight: FontWeight.normal,
              letterSpacing: screenSize.width * 0.0001,
              color: const Color.fromARGB(187, 0, 0, 0),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          const Text('Nome completo:'),
          SizedBox(height: screenSize.height * 0.02),
          textFieldContainer(
            screenSize,
            screenSize.width * 0.575,
            _focusNodeName,
            _nameBorderColor,
            _nameController,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('E-mail cadastrado:'),
                  SizedBox(height: screenSize.height * 0.02),
                  textFieldContainer(
                    screenSize,
                    screenSize.width * 0.27,
                    _focusNodeEmail,
                    _emailBorderColor,
                    _emailController,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Gênero:'),
                  SizedBox(height: screenSize.height * 0.02),
                  Container(
                    width: screenSize.width * 0.27,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: _nameBorderColor, width: 0.75),
                      borderRadius: BorderRadius.circular(
                        screenSize.height * 0.015,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        elevation: 1,
                        value: _selectedGender,
                        menuMaxHeight: screenSize.height * 0.25,
                        items:
                            _options.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans',
                                    fontSize: screenSize.height * 0.018,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(190, 0, 0, 0),
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                            _anyChanges = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(
                          screenSize.height * 0.02,
                        ),
                        decoration: InputDecoration(
                          focusColor: const Color.fromARGB(64, 227, 28, 71),
                          fillColor: Colors.transparent,
                          hoverColor: const Color.fromARGB(64, 227, 28, 71),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.01,
                            vertical: screenSize.height * 0.01,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.02),
          const Text('Endereço:'),
          SizedBox(height: screenSize.height * 0.02),
          textFieldContainer(
            screenSize,
            screenSize.width * 0.571,
            _focusNodeAdress,
            _adressBorderColor,
            _adressController,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Complemento:'),
                  SizedBox(width: screenSize.width * 0.01),
                  textFieldContainer(
                    screenSize,
                    screenSize.width * 0.22,
                    _focusNodeAdressDetails,
                    _adressDetailsBorderColor,
                    _adressDetailsController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bairro:'),
                  SizedBox(width: screenSize.width * 0.01),
                  textFieldContainer(
                    screenSize,
                    screenSize.width * 0.22,
                    _focusNodeNeighborhood,
                    _neighborhoodBorderColor,
                    _neighborhoodController,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Celular:'),
                  SizedBox(width: screenSize.width * 0.01),
                  textFieldContainer(
                    screenSize,
                    screenSize.width * 0.035,
                    _focusNodePhone1DDD,
                    _phone1DDDBorderColor,
                    _phone1DDDController,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  textFieldContainer(
                    screenSize,
                    screenSize.width * 0.17,
                    _focusNodePhone1,
                    _phone1BorderColor,
                    _phone1Controller,
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Telefone Fixo:'),
                  SizedBox(width: screenSize.width * 0.01),
                  textFieldContainer(
                    screenSize,
                    screenSize.width * 0.035,
                    _focusNodePhone2DDD,
                    _phone2DDDBorderColor,
                    _phone2DDDController,
                  ),
                  SizedBox(width: screenSize.width * 0.01),
                  textFieldContainer(
                    screenSize,
                    screenSize.width * 0.17,
                    _focusNodePhone2,
                    _phone2BorderColor,
                    _phone2Controller,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed:
                    _anyChanges
                        ? () {
                          myAccountProvider.updateUserInfos(
                            _nameController.text,
                            _emailController.text,
                            _selectedGender,
                            _adressController.text,
                            _adressDetailsController.text,
                            _neighborhoodController.text,
                            _phone1DDDController.text,
                            _phone1Controller.text,
                            _phone1DDDController.text,
                            _phone2Controller.text,
                          );
                          setState(() {
                            _anyChanges = false;
                          });
                        }
                        : null,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        screenSize.height * 0.01,
                      ),
                    ),
                  ),
                  backgroundColor:
                      _anyChanges
                          ? WidgetStateProperty.all<Color>(
                            Theme.of(context).primaryColorDark,
                          )
                          : WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 177, 177, 177),
                          ),
                  overlayColor: WidgetStateProperty.all<Color>(
                    Colors.transparent,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.005,
                    vertical: screenSize.height * 0.01,
                  ),
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      fontFamily: 'NunitoSansBold',
                      fontSize: screenSize.height * 0.016,
                      fontWeight: FontWeight.bold,
                      letterSpacing: screenSize.width * 0.0001,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.02),
        ],
      ),
    );
  }
}
