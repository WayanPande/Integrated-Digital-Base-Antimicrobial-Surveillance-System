

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_pak_gusan/util/data_class.dart';

class HttpService {
  final String klinikURL = "http://10.0.2.2:3000/klinik";

  Future<List<dynamic>> getKlinik() async {
    http.Response res = await http.get(Uri.parse(klinikURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      print(body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}