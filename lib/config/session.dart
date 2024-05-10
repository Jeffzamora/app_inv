import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/user.dart';
import '../presentation/controller/c_user.dart';

class Session {
  // Método estático para obtener el usuario de las SharedPreferences
  static Future<User?> getUser() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? stringUser = pref.getString('user');
      if (stringUser != null) {
        User user = User.fromJson(jsonDecode(stringUser));
        final cUser = Get.find<CUser>();
        cUser.data = user;
        return user;
      }
    } catch (e) {
      print('Error al obtener el usuario: $e');
    }
    return null; // Devuelve null si no hay usuario guardado o si hay un error
  }

  // Método estático para guardar el usuario en las SharedPreferences
  static Future<bool> saveUser(User user) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool success = await pref.setString('user', jsonEncode(user.toJson()));
      if (success) {
        final cUser = Get.find<CUser>();
        cUser.data = user;
      }
      return success;
    } catch (e) {
      print('Error al guardar el usuario: $e');
      return false;
    }
  }

  // Método estático para eliminar la información del usuario de las SharedPreferences
  static Future<bool> clearUser() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool success = await pref.remove('user');
      final cUser = Get.find<CUser>();
      cUser.data = User(); // Restablece los datos del usuario
      return success;
    } catch (e) {
      print('Error al borrar el usuario: $e');
      return false;
    }
  }
}
