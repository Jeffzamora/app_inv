import 'package:intl/intl.dart';

class AppFormat {
  // Método para formatear un número como moneda
  static String currency(String number) {
    // Utilizar NumberFormat para formatear el número como moneda
    return NumberFormat.currency(
      // Establecer la configuración regional para el formato de moneda (Indonesia)
      locale: 'id_ID',
      // Especificar el símbolo de la moneda (vacío para que no se agregue)
      symbol: '',
      // Especificar el número de dígitos decimales a mostrar
      decimalDigits: 2,
    ).format(double.parse(number)); // Convertir el número a double y formatearlo
  }

  // Método para formatear una fecha
  static String date(String date) {
    // Convertir la cadena de fecha a un objeto DateTime y ajustarlo a la zona horaria local
    DateTime dateTime = DateTime.parse(date).toLocal();
    // Utilizar DateFormat para formatear la fecha en el formato deseado
    return DateFormat('EEE, d MMMM yyyy').format(dateTime);
  }
}
