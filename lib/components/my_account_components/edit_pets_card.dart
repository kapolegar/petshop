import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:petshop/models/pets_infos.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/components/my_account_components/new_pet_dialog.dart';

class EditPets extends StatefulWidget {
  const EditPets({super.key});

  @override
  State<EditPets> createState() => _EditPetsState();
}

class _EditPetsState extends State<EditPets> {
  Future<void> _pickImage(PetsInfos pet) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        pet.imagem = result.files.first.bytes!;
      }
    } catch (e) {
      print("Erro ao selecionar a imagem: $e");
    }
  }

  void _removePet(PetsInfos pet) {
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );
    setState(() {
      int index = myAccountProvider.userPets.indexOf(pet);
      if (index != -1) {
        myAccountProvider.removePet(pet);
      }
    });
  }

  Widget _textFieldContainer(
    Size screenSize,
    double width,
    FocusNode focusNode,
    TextEditingController controller,
    MyAccount myAccountProvider,
    int index,
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
          myAccountProvider.editAnyChanges(index, true);
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
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: screenSize.height * 0.05),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message:
                      myAccountProvider.controllers[index]['anyChanges']
                          ? 'Salvar edições para ${pet.nome}'
                          : '',
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 28, 71),
                    borderRadius: BorderRadius.circular(
                      screenSize.height * 0.01,
                    ),
                  ),
                  textStyle: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: screenSize.height * 0.018,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.edit,
                      color:
                          myAccountProvider.controllers[index]['anyChanges']
                              ? Theme.of(context).primaryColorDark
                              : Colors.grey,
                    ),
                    onPressed:
                        myAccountProvider.controllers[index]['anyChanges']
                            ? () {
                              myAccountProvider.editPet(pet);
                            }
                            : null,
                  ),
                ),
                Tooltip(
                  message: 'Remover ${pet.nome} da lista',
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 28, 71),
                    borderRadius: BorderRadius.circular(
                      screenSize.height * 0.01,
                    ),
                  ),
                  textStyle: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: screenSize.height * 0.018,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () => _removePet(pet),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) => myAccountProvider.editIsHovered(index, true),
                onExit: (_) => myAccountProvider.editIsHovered(index, false),
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
                        if (pet.imagem == null)
                          myAccountProvider.controllers[index]['isHovered']
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
                              pet.imagem!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),

                        if (pet.imagem != null &&
                            myAccountProvider.controllers[index]['isHovered'])
                          Positioned(
                            bottom: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Tooltip(
                                  message: 'Remover foto',
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete_rounded,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      pet.imagem = null;
                                    },
                                  ),
                                ),
                                SizedBox(width: screenSize.width * 0.025),
                                Tooltip(
                                  message: 'Editar foto',
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      _pickImage(pet);
                                    },
                                  ),
                                ),
                              ],
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
                        myAccountProvider.controllers[index]['focusNodeNome'],
                        myAccountProvider.controllers[index]['nomeController'],
                        myAccountProvider,
                        index,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Espécie:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.118,
                        myAccountProvider
                            .controllers[index]['focusNodeEspecie'],
                        myAccountProvider
                            .controllers[index]['especieController'],
                        myAccountProvider,
                        index,
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
                        myAccountProvider.controllers[index]['focusNodeIdade'],
                        myAccountProvider.controllers[index]['idadeController'],
                        myAccountProvider,
                        index,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Porte:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.07,
                        myAccountProvider.controllers[index]['focusNodePorte'],
                        myAccountProvider.controllers[index]['porteController'],
                        myAccountProvider,
                        index,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Pelagem:'),
                      SizedBox(width: screenSize.width * 0.013),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.125,
                        myAccountProvider
                            .controllers[index]['focusNodePelagem'],
                        myAccountProvider
                            .controllers[index]['pelagemController'],
                        myAccountProvider,
                        index,
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
                        myAccountProvider.controllers[index]['focusNodeRaca'],
                        myAccountProvider.controllers[index]['racaController'],
                        myAccountProvider,
                        index,
                      ),
                      SizedBox(width: screenSize.width * 0.015),
                      const Text('Detalhes / Observações:'),
                      SizedBox(width: screenSize.width * 0.015),
                      _textFieldContainer(
                        screenSize,
                        screenSize.width * 0.205,
                        myAccountProvider
                            .controllers[index]['focusNodeDetalhes'],
                        myAccountProvider
                            .controllers[index]['detalhesController'],
                        myAccountProvider,
                        index,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(context);

    return AnimatedContainer(
      width: screenSize.width * 0.6,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
        borderRadius: BorderRadius.circular(screenSize.height * 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenSize.height * 0.03,
              top: screenSize.height * 0.03,
            ),
            child: Text(
              'Meus Pets',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          Padding(
            padding: EdgeInsets.only(left: screenSize.height * 0.03),
            child: Text(
              'Confira os detalhes dos seus pets.',
              style: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.018,
                fontWeight: FontWeight.normal,
                letterSpacing: screenSize.width * 0.0001,
                color: const Color.fromARGB(187, 0, 0, 0),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          for (PetsInfos pet in myAccountProvider.userPets)
            petItem(
              screenSize,
              pet,
              myAccountProvider,
              myAccountProvider.userPets.indexOf(pet),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.023,
              bottom: screenSize.height * 0.03,
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const NewPet();
                  },
                );
              },
              child: Container(
                height: screenSize.height * 0.17,
                width: screenSize.width * 0.085,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.75),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
