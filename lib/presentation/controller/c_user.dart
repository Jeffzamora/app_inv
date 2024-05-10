import 'package:get/get.dart';
import '../../data/model/user.dart';

class CUser extends GetxController {
  // Utilizando Rx para reactividad
  final Rx<User> _data = User().obs;
  // Getter para acceder al valor actual de _data
  User get data => _data.value;
  // Setter para actualizar el valor de _data
  set data(User newData) {
    _data.value = newData;
  }
}