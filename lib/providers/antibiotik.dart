import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../util/data_class.dart';

class Antibiotics with ChangeNotifier {

  List<PemberianAntibiotik> _items = [];

  set items(List<PemberianAntibiotik> value) {
    _items = value;
  }

  List<PemberianAntibiotik> get items {
    return [..._items];
  }

  void addAntibiotik(PemberianAntibiotik value) {

    var data = {};

    data["id_antibiotik"] = value.id_antibiotik;
    data["jalur_pemberian"] = value.jalurPemberian;
    data["dosis"] = value.dosis;
    data["lama_pemberian"] = value.lamaPemberian;


    // _items.add({
    //  id_antibiotik: value.id_antibiotik,
    // jalur_pemberian: value.jalurPemberian,
    //  dosis: value.dosis,
    // lama_pemberian: value.lamaPemberian
    // });

    _items.add(value);


    notifyListeners();
  }


}

