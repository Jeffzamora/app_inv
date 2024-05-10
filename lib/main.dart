import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/app_color.dart';
import 'config/session.dart';
import 'presentation/controller/c_user.dart';
import 'presentation/page/dashboard_page.dart';
import 'presentation/page/login_page.dart';

void main() {
  // Asegura que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();
  // Obtén el usuario de la sesión
  Session.getUser();
  // Ejecuta la aplicación Flutter
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancia el controlador de usuario
    final cUser = Get.put(CUser());
    return GetMaterialApp(
      // Configuración global de la aplicación GetX
      debugShowCheckedModeBanner: false,
      // Configuración del tema de la aplicación
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColor.primary, // Color principal
        scaffoldBackgroundColor: Colors.black, // Color de fondo
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primary, // Color de la barra de aplicación
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColor.primary, // Color primario
        ),
      ),
      // Página de inicio de la aplicación, basada en la condición del usuario
      home: Obx(() {
        // Verifica si el usuario está autenticado
        if (cUser.data.idUser == null) {
          // Si no está autenticado, muestra la página de inicio de sesión
          return const LoginPage();
        } else {
          // Si está autenticado, muestra el panel de control
          return const DashboardPage();
        }
      }),
    );
  }
}