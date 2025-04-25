import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:petshop/models/pets_infos.dart';
import 'package:petshop/providers/my_account_provider.dart';

class NewPet extends StatefulWidget {
  const NewPet({super.key});

  @override
  State<NewPet> createState() => _NewPetState();
}

class _NewPetState extends State<NewPet> {
  bool _anyChanges = false;
  late PetsInfos newPet;

  late TextEditingController nomeController;
  late TextEditingController especieController;
  late TextEditingController racaController;
  late TextEditingController idadeController;
  late TextEditingController porteController;
  late TextEditingController pelagemController;
  late TextEditingController detalhesController;

  FocusNode focusNodeNome = FocusNode();
  FocusNode focusNodeEspecie = FocusNode();
  FocusNode focusNodeIdade = FocusNode();
  FocusNode focusNodePorte = FocusNode();
  FocusNode focusNodePelagem = FocusNode();
  FocusNode focusNodeRaca = FocusNode();
  FocusNode focusNodeDetalhes = FocusNode();

  Uint8List? _selectedImage;
  bool _isHovered = false;

  Future<void> _pickImage(PetsInfos pet) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedImage = result.files.first.bytes;
        });
        pet.imagem = result.files.first.bytes;
      }
    } catch (e) {
      print("Erro ao selecionar a imagem: $e");
    }
  }

  Widget _textFieldContainer(
    Size screenSize,
    double width,
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    return Container(
      width: width,
      height: screenSize.height * 0.05,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(79, 227, 28, 71),
          width: 0.75,
        ),
        borderRadius: BorderRadius.circular(screenSize.height * 0.015),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: (value) {
          setState(() => _anyChanges = true);
        },
        style: TextStyle(
          fontFamily: 'NunitoSans',
          fontSize: screenSize.height * 0.018,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(190, 0, 0, 0),
        ),
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

  Widget petItem(
    Size screenSize,
    PetsInfos pet,
    MyAccount myAccountProvider,
    int index,
  ) {
    return Container(
      height: screenSize.height * 0.35,

      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: GestureDetector(
                  onTap: () => _pickImage(pet),
                  child: Container(
                    height: screenSize.height * 0.17,
                    width: screenSize.width * 0.085,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.75),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_selectedImage == null)
                          _isHovered
                              ? Tooltip(
                                message: 'Adicionar foto',
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 40,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () => _pickImage(pet),
                                ),
                              )
                              : Icon(
                                Icons.pets_rounded,
                                size: 40,
                                color: Theme.of(context).primaryColorDark,
                              )
                        else
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),

                        if (_selectedImage != null && _isHovered)
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Tooltip(
                              message: 'Editar foto',
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () => _pickImage(pet),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenSize.width * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Nome completo:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.18,
                        focusNodeNome,
                        nomeController,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Espécie:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.118,
                        focusNodeEspecie,
                        especieController,
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Row(
                    children: [
                      const Text('Idade aproximada:'),
                      SizedBox(width: screenSize.width * 0.017),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.03,
                        focusNodeIdade,
                        idadeController,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Porte:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.07,
                        focusNodePorte,
                        porteController,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Pelagem:'),
                      SizedBox(width: screenSize.width * 0.013),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.125,
                        focusNodePelagem,
                        pelagemController,
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Row(
                    children: [
                      const Text('Raça:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.07,
                        focusNodeRaca,
                        racaController,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Detalhes / Observações:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.205,
                        focusNodeDetalhes,
                        detalhesController,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.06),
          ElevatedButton(
            onPressed: () {
              newPet = PetsInfos(
                id: myAccountProvider.userPets.length,
                nome: nomeController.text,
                idTutor: myAccountProvider.loggedUserInfos!.id,
                especie: especieController.text,
                raca: racaController.text,
                idade:
                    idadeController.text == ''
                        ? 0
                        : int.parse(idadeController.text),
                porte: porteController.text,
                pelagem: pelagemController.text,
                detalhes: detalhesController.text,
                imagem: _selectedImage,
              );
              myAccountProvider.addPet(newPet);
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.height * 0.01),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).primaryColorDark,
              ),
              overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02,
                vertical: screenSize.height * 0.01,
              ),
              child: Text(
                'Salvar',
                style: TextStyle(
                  fontFamily: 'NunitoSansBold',
                  fontSize: screenSize.height * 0.018,
                  fontWeight: FontWeight.bold,
                  letterSpacing: screenSize.width * 0.0001,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    MyAccount myAccountProvider = Provider.of<MyAccount>(context);
    nomeController = TextEditingController(text: '');
    especieController = TextEditingController(text: '');
    racaController = TextEditingController(text: '');
    idadeController = TextEditingController(text: '');
    porteController = TextEditingController(text: '');
    pelagemController = TextEditingController(text: '');
    detalhesController = TextEditingController(text: '');
    newPet = PetsInfos(
      id: myAccountProvider.userPets.length - 1,
      nome: nomeController.text,
      idTutor: myAccountProvider.loggedUserInfos!.id,
      especie: especieController.text,
      raca: racaController.text,
      idade: idadeController.text == '' ? 0 : int.parse(idadeController.text),
      porte: porteController.text,
      pelagem: pelagemController.text,
      imagem: _selectedImage,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(context);

    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Padding(
        padding: EdgeInsets.all(screenSize.height * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              "Adicionar novo pet",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                _anyChanges
                    ? showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text(
                            'Você possui mudanças não salvas.\nDeseja fechar mesmo assim?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Sim'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Não'),
                            ),
                          ],
                        );
                      },
                    )
                    : Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.height * 0.04),
        child: petItem(
          screenSize,
          newPet,
          myAccountProvider,
          myAccountProvider.userPets.length,
        ),
      ),
    );
  }
}
