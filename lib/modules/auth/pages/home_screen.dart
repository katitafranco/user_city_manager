import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/widgets/action_button.dart';
import '../../../app/widgets/user_info_card.dart';
import '../controllers/auth_controller.dart';
import '../../cities/pages/city_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener datos del usuario actualmente logueado
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
            // Tarjeta de información del usuario
            UserInfoCard(userData: userData, cityData: cityData),
            const SizedBox(height: AppSpacing.lg),

            // Título de la sección de módulos
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                'Módulos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            // Grid de botones de acción
            Expanded(
              child: GridView.count(
                crossAxisCount: AppTheme.gridCrossAxisCount,
                crossAxisSpacing: AppTheme.gridSpacing,
                mainAxisSpacing: AppTheme.gridSpacing,
                childAspectRatio: AppTheme.gridChildAspectRatio,
                children: [
                  ActionButton(
                    // Botón de usuarios
                    icon: Icons.people,
                    label: 'Usuarios',
                    color: AppTheme.userManagementColor,
                    onTap: () => _showComingSoon('Gestión de usuarios'),
                  ),

                  ActionButton(
                    // Botón de ciudades, navega a CityScreen
                    icon: Icons.location_city,
                    label: 'Ciudades',
                    color: AppTheme.cityManagementColor,
                    onTap: () => Get.to(() => CityScreen()),
                  ),

                  ActionButton(
                    // Botón de configuración
                    icon: Icons.settings,
                    label: 'Configuración',
                    color: AppTheme.settingsColor,
                    onTap: () => _showComingSoon('Configuración'),
                  ),

                  ActionButton(
                    // Botón de acerca de
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

  /// Muestra un mensaje tipo Snackbar indicando que la funcionalidad estará disponible pronto
  void _showComingSoon(String feature) {
    Get.snackbar(
      'Próximamente',
      feature,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.primaryColor, // ✅ Usando AppTheme
      colorText: Colors.white,
    );
  }

  /// Muestra un diálogo con información de la aplicación
  void _showAboutDialog() {
    Get.defaultDialog(
      title: 'Acerca de',
      titleStyle: AppTheme.textTheme(
        Get.context!,
      ).titleLarge, // ✅ Estilo usando AppTheme
      contentPadding: AppTheme.dialogPadding, // ✅ Padding usando AppTheme
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Gestión de Usuarios y Ciudades',
            style: AppTheme.textTheme(Get.context!).bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('v1.0.0', style: AppTheme.textTheme(Get.context!).bodySmall),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Conectado a FeathersJS API',
            style: AppTheme.textTheme(
              Get.context!,
            ).bodySmall?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
