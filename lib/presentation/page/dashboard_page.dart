import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/page/employee/employee_page.dart';
import '../../config/session.dart';
import '../controller/c_dashboard.dart';
import 'login_page.dart';
import 'product/product_page.dart';
import '../controller/c_user.dart';
import 'history/history_page.dart';
import 'inout/inout_page.dart';

class AppColor {
  static const Color primary = Color(0xFF4CAF50); // Verde
  static const Color input = Color(0xFFE0F2F1); // Verde pálido
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final cUser = Get.put(CUser());
  final cDashboard = Get.put(CDashboard());

  void logout() async {
    bool? confirm = await DInfo.dialogConfirmation(
      context,
      'Cerrar Sesión',
      '¿Estás seguro de que deseas cerrar sesión?',
    );
    if (confirm ?? false) {
      Session.clearUser();
      Get.off(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          ProfileCard(textTheme: textTheme, cUser: cUser),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Menú', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 16),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              MenuItem(
                text: 'Productos',
                count: cDashboard.product.toString(),
                onTap: () => navigateTo(const ProductPage(), cDashboard.setProduct),
              ),
              MenuItem(
                text: 'Historial',
                count: cDashboard.history.toString(),
                onTap: () => navigateTo(const HistoryPage(), cDashboard.setHistory),
              ),
              MenuItem(
                text: 'Entrada',
                count: cDashboard.ins.toString(),
                onTap: () {
                  navigateTo(
                    const InOutPage(type: 'IN'),
                    () {
                      cDashboard.setIn();
                      cDashboard.setHistory();
                    },
                  );
                },
              ),
              MenuItem(
                text: 'Salida',
                count: cDashboard.outs.toString(),
                onTap: () {
                  navigateTo(
                    const InOutPage(type: 'OUT'),
                    () {
                      cDashboard.setOut();
                      cDashboard.setHistory();
                    },
                  );
                },
              ),
              if (cUser.data.level == 'Admin')
                MenuItem(
                  text: 'Empleados',
                  count: cDashboard.employee.toString(),
                  onTap: () =>
                      navigateTo(const EmployeePage(), cDashboard.setEmployee),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void navigateTo(Widget page, Function()? callback) {
    Get.to(page)?.then((value) => callback?.call());
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final String count;
  final VoidCallback onTap;

  const MenuItem({
    required this.text,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.headline6,
            ),
            Row(
              children: [
                Text(
                  count,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Item',
                  style: TextStyle(color: Colors.white54, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final TextTheme textTheme;
  final CUser cUser;

  const ProfileCard({
    required this.textTheme,
    required this.cUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cUser.data.name ?? '', style: textTheme.headline6),
          const SizedBox(height: 4),
          Text(cUser.data.email ?? '', style: textTheme.bodyText1),
          const SizedBox(height: 8),
          Text('(${cUser.data.level})', style: textTheme.caption),
        ],
      ),
    );
  }
}

