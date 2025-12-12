import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
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
        padding: AppTheme.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoCard(userData: userData, cityData: cityData),
            const SizedBox(height: AppSpacing.lg),

            // Título de la sección
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                'Módulos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            // Action Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: AppTheme.gridCrossAxisCount,
                crossAxisSpacing: AppTheme.gridSpacing,
                mainAxisSpacing: AppTheme.gridSpacing,
                childAspectRatio: AppTheme.gridChildAspectRatio,
                children: [
                  ActionButton(
                    //boton de usuarios
                      icon: Icons.people,
                    label: 'Usuarios',
                    color: AppTheme.userManagementColor,
                    onTap: () => _showComingSoon('Gestión de usuarios'),
                  ),

                  ActionButton(
                    //boton de ciudades
                  icon: Icons.location_city,
                    label: 'Ciudades',
                    color: AppTheme.cityManagementColor,
                    onTap: () => _showComingSoon('Gestión de ciudades'),
                  ),
                  ActionButton(
                    //boton de Settings
                   icon: Icons.settings,
                    label: 'Configuración',
                    color: AppTheme.settingsColor,
                    onTap: () => _showComingSoon('Configuración'),
                  ),
                  ActionButton(
                    //boton de acerca de
                      icon: Icons.info,
                    label: 'Acerca de',
                    color: AppTheme.aboutColor,
                    onTap: _showAboutDialog,
                  ),
                ],
             ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(String feature) {
    Get.snackbar(
      'Próximamente',
      feature,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.primaryColor, // ✅ Usando AppTheme
      colorText: Colors.white,
    );
  }

  void _showAboutDialog() {
    Get.defaultDialog(
      title: 'Acerca de',
      titleStyle: AppTheme.textTheme(Get.context!).titleLarge, // ✅ Otra forma
      contentPadding: AppTheme.dialogPadding, // ✅ Usando AppTheme
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Gestión de Usuarios y Ciudades',
            style: AppTheme.textTheme(Get.context!).bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'v1.0.0',
            style: AppTheme.textTheme(Get.context!).bodySmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Conectado a FeathersJS API',
            style: AppTheme.textTheme(Get.context!).bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}