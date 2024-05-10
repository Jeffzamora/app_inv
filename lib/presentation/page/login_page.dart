import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d_info/d_info.dart';
import '../../presentation/controller/c_user.dart';
import '../../data/source/source_user.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final cUser = Get.put(CUser());

  bool _obscurePassword = true; // Variable para controlar la visibilidad de la contraseña

  void login() async {
    bool success = await SourceUser.login(
      controllerEmail.text,
      controllerPassword.text,
    );
    if (success) {
      DInfo.dialogSuccess('Login Success');
      DInfo.closeDialog(actionAfterClose: () {
        if (cUser.data.level == 'Employee' && controllerPassword.text == '123456') {
          changePassword();
        } else {
          Get.off(() => const DashboardPage());
        }
      });
    } else {
      DInfo.dialogError('Login failed');
      DInfo.closeDialog();
    }
  }

  void changePassword() async {
    final controller = TextEditingController();
    bool yes = await Get.dialog(
      AlertDialog(
        title: const Text('Have to Change Password'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'New Password',
          ),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Change'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    if (yes) {
      bool success = await SourceUser.changePassword(
        cUser.data.idUser.toString(),
        controller.text,
      );
      if (success) {
        DInfo.dialogSuccess('Change Password Success');
        DInfo.closeDialog(actionAfterClose: () {
          Get.off(() => const DashboardPage());
        });
      } else {
        DInfo.dialogError('Change Password Failed');
        DInfo.closeDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '../../../images/logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllerEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controllerPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // Cambiar la visibilidad de la contraseña
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword, // Utilizar la variable para controlar la visibilidad de la contraseña
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(),
              child: const Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3366CC),
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}