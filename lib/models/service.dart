class PetService {
  final String id;
  final int servico;
  final String petID;
  final String dataSolicitacao;
  final String data;
  final String hora;
  final String status;
  final String? observacoes;

  PetService({
    required this.id,
    required this.servico,
    required this.petID,
    required this.dataSolicitacao,
    required this.data,
    required this.hora,
    required this.status,
    this.observacoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'Serviço': servico.toString(),
      'PetID': petID,
      'Data da Solicitação': dataSolicitacao,
      'Data': data,
      'Hora': hora,
      'Status': status,
      'Observações': observacoes,
    };
  }
}
