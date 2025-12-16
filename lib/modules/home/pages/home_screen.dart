import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/widgets/buttons/action_button.dart';
import '../../../app/widgets/card/user_info_card.dart';
import '../controller/home_logic.dart';
import '../../cities/pages/city_screen.dart';

class HomeScreen extends GetView<HomeLogic> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
            tooltip: 'Cerrar Sesión',
          ),
        ],
      ),
      body: Padding(
        padding: AppTheme.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del usuario
            Obx(
              () => UserInfoCard(
                userData: controller.state.userData.value,
                cityData: controller.state.cityData.value,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Título de módulos
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                'Módulos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            // Grid de acciones
            Expanded(
              child: GridView.count(
                crossAxisCount: AppTheme.gridCrossAxisCount,
                crossAxisSpacing: AppTheme.gridSpacing,
                mainAxisSpacing: AppTheme.gridSpacing,
                childAspectRatio: AppTheme.gridChildAspectRatio,
                children: [
                  ActionButton(
                    icon: Icons.people,
                    label: 'Usuarios',
                    color: AppTheme.userManagementColor,
                    onTap: () => controller.showComingSoon('Gestión de usuarios'),
                  ),
                  ActionButton(
                    icon: Icons.location_city,
                    label: 'Ciudades',
                    color: AppTheme.cityManagementColor,
                    onTap: () => Get.to(() => CityScreen()),
                  ),
                  ActionButton(
                    icon: Icons.settings,
                    label: 'Configuración',
                    color: AppTheme.settingsColor,
                    onTap: () => controller.showComingSoon('Configuración'),
                  ),
                  ActionButton(
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

  /// Muestra el diálogo "Acerca de"
  void _showAboutDialog() {
    Get.defaultDialog(
      title: 'Acerca de',
      content: const Text('Gestión de Usuarios y Ciudades'),
    );
  }
}
