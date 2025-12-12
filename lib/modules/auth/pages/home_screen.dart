import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/widgets/action_button.dart';
import '../../../app/widgets/user_info_card.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = _authController.getCurrentUser();
    final cityData = userData?['city'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _authController.logout,
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoCard(userData: userData, cityData: cityData),
            const SizedBox(height: 24),

            // Action Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  ActionButton(
                    //boton de usuarios
                    icon: Icons.people,
                    label: 'Usuarios',
                    color: Colors.blue,
                    onTap: () {
                      Get.snackbar(
                        'Próximamente',
                        'Gestión de usuarios',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),

                  ActionButton(
                    //boton de ciudades
                    icon: Icons.location_city,
                    label: 'Ciudades',
                    color: Colors.green,
                    onTap: () {
                      Get.snackbar(
                        'Próximamente',
                        'Gestión de ciudades',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  ActionButton(
                    //boton de Settings
                    icon: Icons.settings,
                    label: 'Configuración',
                    color: Colors.orange,
                    onTap: () {
                      Get.snackbar(
                        'Próximamente',
                        'Configuración',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                  ActionButton(
                    //boton de acerca de
                    icon: Icons.info,
                    label: 'Acerca de',
                    color: Colors.purple,
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Acerca de',
                        content: const Column(
                          children: [
                            Text('Gestión de Usuarios y Ciudades'),
                            SizedBox(height: 8),
                            Text('v1.0.0'),
                            SizedBox(height: 8),
                            Text('Conectado a FeathersJS API'),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
