import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:petshop/models/service.dart';
import 'package:petshop/models/banho_e_tosa_schedule.dart';
import 'package:petshop/models/consulta_veterinaria.schedule.dart';

class Services extends ChangeNotifier {
  final List<PetService> _services = [];
  List<BanhoETosaSchedule> _horariosBanhoETosaDisponiveis = [];
  List<ConsultaVeterinariaSchedule> _horariosConsultaVeterinariaDisponiveis =
      [];

  final Map<String, int> _servicesList = {
    'Banho e tosa': 0,
    'Só banho': 1,
    'Só tosa': 2,
    'Consulta Veterinária': 3,
  };

  final Map<String, int> _servicesStatusList = {
    'Agendado': 0,
    'Cancelado': 1,
    'Finalizado': 2,
  };

  final List<dynamic> _horariosConsultaVeterinaria = [
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '09:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '10:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '11:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '12:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '13:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '14:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '15:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '16:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '17:00',
      'pet': '',
      'observacoes': '',
    },

    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '09:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '10:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '11:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '12:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '13:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '14:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '15:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '16:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '17:00',
      'pet': '',
      'observacoes': '',
    },

    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '09:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '10:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '11:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '12:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '13:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '14:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '15:00',
      'pet': 'Pepa',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '16:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '17:00',
      'pet': '',
      'observacoes': '',
    },

    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '09:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '10:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '11:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '12:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '13:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '14:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '15:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '16:00',
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '17:00',
      'pet': '',
      'observacoes': '',
    },
  ];
  final List<dynamic> _horariosBanhoETosa = [
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '09:00',
      'servico': 1,
      'pet': 'Pablo',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '10:00',
      'servico': 1,
      'pet': 'Velho',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '11:00',
      'servico': 1,
      'pet': 'Otto',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '12:00',
      'servico': 1,
      'pet': 'Luna',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '13:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '14:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '15:00',
      'servico': 1,
      'pet': 'Boris',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '16:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'horario': '17:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },

    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '09:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '10:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '11:00',
      'servico': 1,
      'pet': 'Naná',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '12:00',
      'servico': 1,
      'pet': 'Neko',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '13:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '14:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '15:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '16:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 1))),
      'horario': '17:00',
      'servico': 1,
      'pet': 'Lulu',
      'observacoes': '',
    },

    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '09:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '10:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '11:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '12:00',
      'servico': 1,
      'pet': 'Bia',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '13:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '14:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '15:00',
      'servico': 1,
      'pet': 'Pepa',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '16:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 2))),
      'horario': '17:00',
      'servico': 1,
      'pet': 'Mini',
      'observacoes': '',
    },

    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '09:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '10:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '11:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '12:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '13:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '14:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '15:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '16:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
    {
      'dia': DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now().add(const Duration(days: 3))),
      'horario': '17:00',
      'servico': 1,
      'pet': '',
      'observacoes': '',
    },
  ];

  List<PetService> get services => _services;
  Map<String, int> get servicesList => _servicesList;
  Map<String, int> get servicesStatusList => _servicesStatusList;
  List<BanhoETosaSchedule> get horariosBanhoETosaDisponiveis =>
      _horariosBanhoETosaDisponiveis;
  List<ConsultaVeterinariaSchedule>
  get horariosConsultaVeterinariaDisponiveis =>
      _horariosConsultaVeterinariaDisponiveis;

  addToServices(PetService newService) {
    _services.add(newService);
    notifyListeners();
  }

  getBanhoETosaSchedules() {
    _horariosBanhoETosaDisponiveis = [];

    for (var item in _horariosBanhoETosa) {
      _horariosBanhoETosaDisponiveis.add(
        BanhoETosaSchedule(
          day: DateFormat("dd/MM/yyyy").parse(item['dia']),
          schedule: item['horario'],
          service: item['servico'],
          pet: item['pet'],
          obs: item['observacoes'],
        ),
      );
    }
    notifyListeners();
  }

  updateBanhoETosaSchedule(BanhoETosaSchedule newSchedule) {
    BanhoETosaSchedule novoAgendamento = _horariosBanhoETosaDisponiveis
        .firstWhere(
          (item) =>
              item.day == newSchedule.day &&
              item.schedule == newSchedule.schedule,
        );
    novoAgendamento.pet = newSchedule.pet;
    novoAgendamento.obs = newSchedule.obs;

    Map<String, dynamic>? horarioOriginal = _horariosBanhoETosa.firstWhere(
      (item) =>
          item['dia'] == DateFormat('dd/MM/yyyy').format(newSchedule.day) &&
          item['horario'] == newSchedule.schedule,
      orElse: () => null,
    );

    if (horarioOriginal != null) {
      horarioOriginal['pet'] = newSchedule.pet;
      horarioOriginal['observacoes'] = newSchedule.obs;
    }
    notifyListeners();
  }

  getConsultaVeterinariaSchedules() {
    _horariosConsultaVeterinariaDisponiveis = [];

    for (var item in _horariosConsultaVeterinaria) {
      _horariosConsultaVeterinariaDisponiveis.add(
        ConsultaVeterinariaSchedule(
          day: DateFormat("dd/MM/yyyy").parse(item['dia']),
          schedule: item['horario'],
          pet: item['pet'],
          obs: item['observacoes'],
        ),
      );
    }
    notifyListeners();
  }

  updateConsultaVeterinariaSchedule(ConsultaVeterinariaSchedule newSchedule) {
    ConsultaVeterinariaSchedule novoAgendamento =
        _horariosConsultaVeterinariaDisponiveis.firstWhere(
          (item) =>
              item.day == newSchedule.day &&
              item.schedule == newSchedule.schedule,
        );
    novoAgendamento.pet = newSchedule.pet;
    novoAgendamento.obs = newSchedule.obs;

    Map<String, dynamic>? horarioOriginal = _horariosConsultaVeterinaria
        .firstWhere(
          (item) =>
              item['dia'] == DateFormat('dd/MM/yyyy').format(newSchedule.day) &&
              item['horario'] == newSchedule.schedule,
          orElse: () => null,
        );

    if (horarioOriginal != null) {
      horarioOriginal['pet'] = newSchedule.pet;
      horarioOriginal['observacoes'] = newSchedule.obs;
    }
    notifyListeners();
  }
}
