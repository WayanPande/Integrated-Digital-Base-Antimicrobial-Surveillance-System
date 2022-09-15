
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_pak_gusan/util/data_class.dart';
import 'package:project_pak_gusan/util/sharedPreferences.dart';

import '../service/http_service.dart';

class Doctors with ChangeNotifier {
  Map<String, dynamic> items = {};

  Doktor dokterDetail = Doktor();

  bool loggedIn = false;

  Doktor newDoktor = Doktor();

  Future<void> addDokter() async {
    try {
      await HttpService().addDoktor(newDoktor);
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> login(LoginData data) async {
    items = {};
    try {
     var response =  await HttpService().login(data);
     if(!response['error']){
       items = response;
       if(response['msg'] == "fail") {
         Logger().d(response['msg']);
       }else {
         addDoktorId(response['id']);
         loggedIn = true;
       }
     }
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getDokter() async {
    var id = await getDoktorId();

    if(id != null) {
      try {
        var data = await HttpService().getDoktor(id);
        dokterDetail = Doktor.fromJson(data);
      } catch (error) {
        rethrow;
      }
    }
    notifyListeners();
  }

}