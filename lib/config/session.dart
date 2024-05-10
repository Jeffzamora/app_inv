import 'dart:convert';
import 'package:get/get.dart';
import '../presentation/controller/c_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/user.dart';

class Session {
  // Método para obtener el usuario almacenado en SharedPreferences
  static Future<User> getUser() async {
    User user = User(); // Crear una instancia de usuario vacía
    SharedPreferences pref = await SharedPreferences.getInstance(); // Obtener SharedPreferences
    String? stringUser = pref.getString('user'); // Obtener el usuario como cadena JSON
    if (stringUser != null) {
      // Si la cadena de usuario no es nula, decodificarla y asignarla al usuario
      user = User.fromJson(jsonDecode(stringUser));
    }
    final cUser = Get.put(CUser()); // Obtener el controlador de usuario utilizando GetX
    cUser.data = user; // Asignar el usuario al controlador de usuario
    return user; // Devolver el usuario
  }

  // Método para guardar el usuario en SharedPreferences
  static Future<bool> saveUser(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance(); // Obtener SharedPreferences
    // Convertir el usuario a JSON y guardarlo en SharedPreferences
    bool success = await pref.setString('user', jsonEncode(user.toJson()));
    final cUser = Get.put(CUser()); // Obtener el controlador de usuario utilizando GetX
    if (success) cUser.data = user; // Si se guardó correctamente, asignar el usuario al controlador de usuario
    return success; // Devolver true si se guardó correctamente, de lo contrario false
  }

  // Método para eliminar el usuario de SharedPreferences
  static Future<bool> clearUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance(); // Obtener SharedPreferences
    bool success = await pref.remove('user'); // Eliminar el usuario de SharedPreferences
    final cUser = Get.put(CUser()); // Obtener el controlador de usuario utilizando GetX
    cUser.data = User(); // Asignar un usuario vacío al controlador de usuario
    return success; // Devolver true si se eliminó correctamente, de lo contrario false
  }
}

