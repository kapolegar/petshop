class LoggedUserInfos {
  int id;
  String nome;
  String email;
  String token;
  String? genero;
  String? endereco;
  String? complemento;
  String? bairro;
  String? dddCelular;
  String? celular;
  String? dddTelefoneFixo;
  String? telefoneFixo;

  LoggedUserInfos({
    required this.id,
    required this.nome,
    required this.email,
    required this.token,
  });
}
