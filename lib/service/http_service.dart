import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project_pak_gusan/util/data_class.dart';

class HttpService {
  Future<List<dynamic>> getPasien() async {
    final String pasienURL = "${dotenv.env['API_URL']}pasien";
    http.Response res = await http.get(Uri.parse(pasienURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Map<String, dynamic>> getPasienById(int id) async {
    final String pasienURL = "${dotenv.env['API_URL']}pasien/$id";
    http.Response res = await http.get(Uri.parse(pasienURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Map<String, dynamic>> deletePasien(int id) async {
    final String pasienURL = "${dotenv.env['API_URL']}pasien/$id";
    http.Response res = await http.delete(Uri.parse(pasienURL));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Map<String, dynamic>> addNewPasien(Pasien? item) async {
   final String pasienkURL = "${dotenv.env['API_URL']}pasien";

   http.Response res = await http
       .post(
     Uri.parse(pasienkURL),
     headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
     },
     body: jsonEncode(item),
   );

   if (res.statusCode == 200) {
     Map<String, dynamic> body = jsonDecode(res.body);
     return body;
   } else {
     throw "Unable to retrieve posts.";
   }
  }

  Future<List<dynamic>> updatePasien(Pasien data, int id) async {
    final String pasienkURL = "${dotenv.env['API_URL']}pasien/$id";

    http.Response res = await http
        .put(
      Uri.parse(pasienkURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Map<String, dynamic>> addDoktor(Doktor? item) async{
    final String doktorURL = "${dotenv.env['API_URL']}dokter";

    http.Response res = await http
        .post(
      Uri.parse(doktorURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
