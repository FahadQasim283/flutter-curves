import 'package:practice/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future setCoordinates({
  required String latitude,
  required String longitude,
  required String timeStamp,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> list = [];
  list = await getCoordinates();
  list.add("$latitude,$longitude,$timeStamp");
  await prefs.setStringList(coordinatesKey, list);
}

Future<List<String>> getCoordinates() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(coordinatesKey) ?? [];
}

Future<void> clearCoordinates() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(coordinatesKey);
  await prefs.remove(timeKey);
}

//session management
Future<void> setUserType(String userType) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(userTypeKey, userType);
}

Future<String> getUserType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(userTypeKey) ?? '';
}
