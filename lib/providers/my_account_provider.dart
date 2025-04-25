import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petshop/constants.dart';
import 'package:petshop/models/order.dart';
import 'package:petshop/models/pets_infos.dart';
import 'package:petshop/models/credit_card.dart';
import 'package:petshop/models/logged_user_infos.dart';
import 'package:petshop/providers/selected_screen_provider.dart';

class MyAccount extends ChangeNotifier {
  String _loginValidation = '';
  LoggedUserInfos? _loggedUserInfos;
  Widget _accountDetailsScreen = const SizedBox();
  final List<Map<String, dynamic>> _controllers = [];
  final List<PetsInfos> _userPets = [];
  final List<Order> _orders = [];
  final List<CreditCard> _myCreditCards = [
    CreditCard(
      number: '0000 0000 0000 0000',
      owner: 'Dono do Cartão',
      expirationDate: '02/30',
      cvv: '000',
      flag: 'Banco Pets',
    ),
  ];

  List<Order> get orders => _orders;
  List<PetsInfos> get userPets => _userPets;
  String get loginValidation => _loginValidation;
  List<CreditCard> get myCreditCards => _myCreditCards;
  Widget get accountDetailsScreen => _accountDetailsScreen;
  LoggedUserInfos? get loggedUserInfos => _loggedUserInfos;
  List<Map<String, dynamic>> get controllers => _controllers;

  addCreditCard(CreditCard newCard) {
    _myCreditCards.add(newCard);
    notifyListeners();
  }

  updateAccountDetailsScreen(Widget screen) {
    _accountDetailsScreen = screen;
    notifyListeners();
  }

  void validateLogin(
    String email,
    String senha,
    SelectScreen selectedScreen,
  ) async {
    _loginValidation = '';
    try {
      if (email.isEmpty && senha.isEmpty) {
        _loginValidation = 'O campo de e-mail e senha devem ser preenchidos.';
      } else if (email.isEmpty) {
        _loginValidation = 'O campo de e-mail deve ser preenchido.';
      } else if (senha.isEmpty) {
        _loginValidation = 'O campo de senha deve ser preenchido.';
      } else {
        Map<String, dynamic> data = Constants().login.firstWhere(
          (element) => element['Login'] == email,
        );

        if (data['Senha'] == senha) {
          _loggedUserInfos = LoggedUserInfos(
            id: 0,
            nome: data['Nome'],
            email: email,
            token: data['Token'],
          );
          loadPets();
        } else {
          _loginValidation = 'Senha incorreta. Tente novamente.';
        }
      }
    } catch (e) {
      print(e);
      _loginValidation =
          'Usuário não encontrado. Faça o cadastro no site e tente novamente.';
    }
    notifyListeners();
  }

  updateUserInfos(
    String nome,
    String email,
    String? genero,
    String? endereco,
    String? complemento,
    String? bairro,
    String? dddCelular,
    String? celular,
    String? dddtelefoneFixo,
    String? telefoneFixo,
  ) {
    _loggedUserInfos!.nome = nome;
    _loggedUserInfos!.email = email;
    _loggedUserInfos!.genero = genero;
    _loggedUserInfos!.endereco = endereco;
    _loggedUserInfos!.complemento = complemento;
    _loggedUserInfos!.bairro = bairro;
    _loggedUserInfos!.dddCelular = dddCelular;
    _loggedUserInfos!.celular = celular;
    _loggedUserInfos!.dddTelefoneFixo = dddtelefoneFixo;
    _loggedUserInfos!.telefoneFixo = telefoneFixo;
  }

  addPet(PetsInfos pet) {
    _userPets.add(pet);
    _controllers.add({
      'nomeController': TextEditingController(text: pet.nome),
      'especieController': TextEditingController(text: pet.especie),
      'idadeController': TextEditingController(text: pet.idade.toString()),
      'porteController': TextEditingController(text: pet.porte),
      'pelagemController': TextEditingController(text: pet.pelagem),
      'racaController': TextEditingController(text: pet.raca),
      'detalhesController': TextEditingController(text: pet.detalhes),
      'focusNodeNome': FocusNode(),
      'focusNodeEspecie': FocusNode(),
      'focusNodeIdade': FocusNode(),
      'focusNodePorte': FocusNode(),
      'focusNodePelagem': FocusNode(),
      'focusNodeRaca': FocusNode(),
      'focusNodeDetalhes': FocusNode(),
      'anyChanges': false,
      'isHovered': false,
    });
    notifyListeners();
  }

  editAnyChanges(int index, bool anyChanges) {
    controllers[index]['anyChanges'] = anyChanges;
    notifyListeners();
  }

  editIsHovered(int index, bool isHovered) {
    controllers[index]['isHovered'] = isHovered;
    notifyListeners();
  }

  editPet(PetsInfos pet) {
    int index = _userPets.indexWhere((element) => element.id == pet.id);
    _userPets.removeAt(index);
    _userPets.insert(index, pet);
    _controllers[index]['anyChanges'] = false;
    notifyListeners();
  }

  removePet(PetsInfos pet) {
    int index = _userPets.indexOf(pet);
    _userPets.removeAt(index);
    _controllers.removeAt(index);
    notifyListeners();
  }

  Future<void> loadPets() async {
    final String response = await rootBundle.loadString('data/pets.json');
    final List<dynamic> data = json.decode(response);

    _userPets.clear();
    _userPets.addAll(data.map((item) => PetsInfos.fromJson(item)).toList());

    for (var pet in _userPets) {
      await pet.carregarImagem();
    }

    for (PetsInfos pet in userPets) {
      _controllers.add({
        'nomeController': TextEditingController(text: pet.nome),
        'especieController': TextEditingController(text: pet.especie),
        'idadeController': TextEditingController(text: pet.idade.toString()),
        'porteController': TextEditingController(text: pet.porte),
        'pelagemController': TextEditingController(text: pet.pelagem),
        'racaController': TextEditingController(text: pet.raca),
        'detalhesController': TextEditingController(text: pet.detalhes),
        'focusNodeNome': FocusNode(),
        'focusNodeEspecie': FocusNode(),
        'focusNodeIdade': FocusNode(),
        'focusNodePorte': FocusNode(),
        'focusNodePelagem': FocusNode(),
        'focusNodeRaca': FocusNode(),
        'focusNodeDetalhes': FocusNode(),
        'anyChanges': false,
        'isHovered': false,
      });
    }
    notifyListeners();
  }
}
