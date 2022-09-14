
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_pak_gusan/util/data_class.dart';

import '../service/http_service.dart';

class Doctors with ChangeNotifier {
  Map<String, Doktor> _items = {};

  Map<String, Doktor> get items {
    return {..._items};
  }

  Doktor newDoktor = Doktor();

  Future<void> addDokter() async {

    Logger().d(newDoktor.jenisDokter);

    try {
      await HttpService().addDoktor(newDoktor);
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

}