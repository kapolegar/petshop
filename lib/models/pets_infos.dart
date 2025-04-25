
import 'package:flutter/services.dart';

class PetsInfos {
  int id;
  String nome;
  int idTutor;
  String especie;
  String raca;
  int idade;
  String porte;
  String pelagem;
  String? detalhes;
  Uint8List? imagem;
  String? imagemPath;

  PetsInfos({
    required this.id,
    required this.nome,
    required this.idTutor,
    required this.especie,
    required this.raca,
    required this.idade,
    required this.porte,
    required this.pelagem,
    this.detalhes,
    this.imagem,
    this.imagemPath,
  });

  factory PetsInfos.fromJson(Map<String, dynamic> json) {
    return PetsInfos(
      id: int.parse(json['id']),
      nome: json['nome'],
      idTutor: int.parse(json['idTutor']),
      especie: json['especie'],
      raca: json['raca'],
      idade: int.parse(json['idade']),
      porte: json['porte'],
      pelagem: json['pelagem'],
      detalhes: json['detalhes'] ?? '',
      imagemPath: json['imagem'] ?? '',
    );
  }

  Future<void> carregarImagem() async {
    if (imagemPath != null) {
      ByteData data = await rootBundle.load(imagemPath!);
      imagem = data.buffer.asUint8List();
    }
  }

  Map<String, String> toMap() {
    return {
      'ID': id.toString(),
      'Nome': nome,
      'Espécie': especie,
      'Raça': raca,
      'Idade': '${idade.toString()} anos',
      'Porte': porte,
      'Pelagem': pelagem,
      'Detalhes': detalhes ?? '',
    };
  }
}
