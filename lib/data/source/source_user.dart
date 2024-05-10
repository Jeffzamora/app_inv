import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import '../../config/api.dart';
import '../../config/app_request.dart';
import '../../config/session.dart';

import '../model/user.dart';

class SourceUser {
  static Future<int> count() async {
    try {
      String url = '${Api.user}/${Api.count}';
      String? responseBody = await AppRequest.gets(url);
      if (responseBody != null) {
        Map<String, dynamic> result = jsonDecode(responseBody);
        return result['data'];
      }
    } catch (e) {
      // Manejar errores de red, errores de análisis JSON, etc.
      print('Error en SourceUser.count: $e');
    }
    return 0;
  }

  static Future<bool> login(String email, String password) async {
    try {
      String url = '${Api.user}/login.php';
      String? responseBody = await AppRequest.post(url, {
        'email': email,
        'password': password,
      });
      if (responseBody != null) {
        Map<String, dynamic> result = jsonDecode(responseBody);
        if (result['success']) {
          DMethod.printTitle('SourceUser - login', 'Success');
          Map<String, dynamic> userMap = result['data'];
          Session.saveUser(User.fromJson(userMap));
        } else {
          DMethod.printTitle('SourceUser - login', 'failed');
        }
        return result['success'];
      }
    } catch (e) {
      print('Error en SourceUser.login: $e');
    }
    return false;
  }

  static Future<List<User>> gets() async {
    try {
      String url = '${Api.user}/${Api.gets}';
      String? responseBody = await AppRequest.gets(url);
      if (responseBody != null) {
        Map<String, dynamic> result = jsonDecode(responseBody);
        if (result['success']) {
          List<dynamic> list = result['data'];
          return list.map((e) => User.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print('Error en SourceUser.gets: $e');
    }
    return [];
  }

  static Future<bool> add(String name, String email, String password) async {
    try {
      String url = '${Api.user}/${Api.add}';
      String? responseBody = await AppRequest.post(url, {
        'name': name,
        'email': email,
        'password': password,
      });
      if (responseBody != null) {
        Map<String, dynamic> result = jsonDecode(responseBody);
        if (result['success']) {
          return true;
        } else {
          if (result['message'] == 'email') {
            DInfo.toastError('Email is already used');
          }
          return false;
        }
      }
    } catch (e) {
      print('Error en SourceUser.add: $e');
    }
    return false;
  }

  static Future<bool> delete(String idUser) async {
    try {
      String url = '${Api.user}/${Api.delete}';
      String? responseBody = await AppRequest.post(url, {'id_user': idUser});
      if (responseBody != null) {
        Map<String, dynamic> result = jsonDecode(responseBody);
        return result['success'];
      }
    } catch (e) {
      print('Error en SourceUser.delete: $e');
    }
    return false;
  }

  static Future<bool> changePassword(String idUser, String newPassword) async {
    try {
      String url = '${Api.user}/change_password.php';
      String? responseBody = await AppRequest.post(
        url,
        {'id_user': idUser, 'password': newPassword},
      );
      if (responseBody != null) {
        Map<String, dynamic> result = jsonDecode(responseBody);
        return result['success'];
      }
    } catch (e) {
      print('Error en SourceUser.changePassword: $e');
    }
    return false;
  }
}
