
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

addDoktorId(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('doktor_id', id);
}

Future<int?> getDoktorId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt('doktor_id');
  return id;
}

removeDoktorId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('doktor_id');
}

