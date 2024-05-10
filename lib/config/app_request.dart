import 'package:d_method/d_method.dart';
import 'package:http/http.dart' as http;

class AppRequest {
  // Método para realizar una solicitud GET
  static Future<String?> gets(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      // Realizar la solicitud GET utilizando el paquete http
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      // Imprimir el título y el cuerpo de la respuesta para fines de depuración
      DMethod.printTitle('try - $url', response.body);
      // Devolver el cuerpo de la respuesta
      return response.body;
    } catch (e) {
      // Si ocurre una excepción, imprimir el título y el mensaje de error
      DMethod.printTitle('catch - $url', e.toString());
      // Devolver null en caso de error
      return null;
    }
  }

  // Método para realizar una solicitud POST
  static Future<String?> post(
    String url,
    Object? data, {
    Map<String, String>? headers,
  }) async {
    try {
      // Realizar la solicitud POST utilizando el paquete http
      var response = await http.post(
        Uri.parse(url),
        body: data,
        headers: headers,
      );
      // Imprimir el título y el cuerpo de la respuesta para fines de depuración
      DMethod.printTitle('try - $url', response.body);
      // Devolver el cuerpo de la respuesta
      return response.body;
    } catch (e) {
      // Si ocurre una excepción, imprimir el título y el mensaje de error
      DMethod.printTitle('catch - $url', e.toString());
      // Devolver null en caso de error
      return null;
    }
  }
}

