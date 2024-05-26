import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefference {
  static SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> addTime() async {
    List<String> time = [];
    time = getTimeStamp();
    time.add(DateTime.now().toString());
    await _preferences!.setStringList('time', time);
  }

  static List<String> getTimeStamp() =>
      _preferences!.getStringList("time") ?? [];

  static Future setLts(String lats) async {
    List<String> lts = [];
    lts = getLats();
    lts.add(lats);
    await _preferences!.setStringList('lats', lts);
  }

  static List<String> getLats() => _preferences!.getStringList('lats') ?? [];

  static Future setLongs(String longs) async {
    List<String> lng = [];
    lng = getLongs();
    lng.add(longs);
    await _preferences!.setStringList('longs', lng);
  }
  static List<String> getLongs() => _preferences!.getStringList('longs') ?? [];
  static Future<void> clear() async => await _preferences!.clear();
}
