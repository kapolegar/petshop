class Product {
  final String id;
  final String nome;
  final String descricao;
  final String preco;
  final String imagemUrl;
  final String categoria;
  final String pet;
  final String estoque;

  Product({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    required this.categoria,
    required this.pet,
    required this.estoque,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagemUrl': imagemUrl,
      'categoria': categoria,
      'pet': pet,
      'estoque': estoque,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      preco: json['preco'],
      imagemUrl: json['imagemUrl'],
      categoria: json['categoria'],
      pet: json['pet'],
      estoque: json['estoque'],
    );
  }
}
