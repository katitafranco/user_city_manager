import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/widgets/app_card.dart';
import '../../../app/widgets/app_text_field.dart';
import '../../../app/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class LoginScreenGetX extends GetView<AuthController> {
  const LoginScreenGetX({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // LOGO
                Icon(Icons.person_pin_circle_outlined, size: 80, color: theme.colorScheme.primary),
                const SizedBox(height: 16),

                Text(
                  'Gestión de Usuarios y Ciudades',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                Text(
                  'Inicia sesión para continuar',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // 🔵 AHORA USAS AppCard
                AppCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: 'Correo Electrónico',
                        hintText: 'ejemplo@correo.com',
                        controller: controller.state.emailController.value,
                        icon: Icons.email_outlined,
                        onChanged: () {
                          controller.state.errorMessage.value = '';
                          controller.isFormValid();
                        },
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Contraseña',
                        hintText: 'Ingresa tu contraseña',
                        controller: controller.state.passwordController.value,
                        icon: Icons.lock_outline,
                        isPassword: true,
                        onChanged: () {
                          controller.state.errorMessage.value = '';
                          controller.isFormValid();
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 🔵 PRIMARY BUTTON
                Obx(
                  () => PrimaryButton(
                    text: 'Iniciar Sesión',
                    onPressed: controller.state.isCredentialValid.value ? controller.performLogin : null,
                    isLoading: controller.state.isLoading.value,
                  ),
                ),

                const SizedBox(height: 16),

                // AUTORELLENAR – Solo dev
                ElevatedButton(
                  onPressed: () {
                    controller.state.emailController.value.text = 'jc@gmail.com';
                    controller.state.passwordController.value.text = '111111';
                    controller.isFormValid();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('AUTORELLENAR (Prueba)'),
                ),

                const SizedBox(height: 16),

                // ERROR MESSAGE
                Obx(
                  () => controller.state.errorMessage.value.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(controller.state.errorMessage.value, style: TextStyle(color: Colors.red[600], fontSize: 14)),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
