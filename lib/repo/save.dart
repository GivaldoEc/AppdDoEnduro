import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appdowill/config/preferences_keys.dart';
import 'package:appdowill/repo/models/user.dart';

class CarRepository {
  late SharedPreferences sharedPreferences;

  Future<User> getCarList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String jsonString =
        sharedPreferences.getString(PreferenceKeys.chave) ?? '[]';
    // print(jsonString);
    Map<String, dynamic> mapUser = json.decode(jsonString);
    User user = User.fromJson(mapUser);
    return user;
  }

  void saveCarList(List<User> name, number) {
    final String jsonString = json.encode(name);
    final dynamic jsonInt = json.encode(number);

    sharedPreferences.setString(PreferenceKeys.chave, jsonString);
  }

  static fromJson(e) {}
}
