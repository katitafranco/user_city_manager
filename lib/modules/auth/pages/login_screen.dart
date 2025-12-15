import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/utils/logger.dart';
import '../../../app/widgets/app_card.dart';
import '../../../app/widgets/app_text_field.dart';
import '../../../app/widgets/primary_button.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Opcional: Autocompletar para pruebas
    // _emailController.text = 'jc@gmail.com';
    // _passwordController.text = '111111';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin() {
    AppLogger.info('🎯 Botón presionado - Iniciando login');
    AppLogger.info(' Email: ${_emailController.text}');
    AppLogger.info('  Password: ${_passwordController.text}');

    _authController.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  bool _isFormValid() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final isValid =
        email.isNotEmpty &&
        password.isNotEmpty &&
        email.contains('@') &&
        email.contains('.') &&
        password.length >= 6;

    AppLogger.info(
      '📋 Validación: $isValid (email: $email, password: ${'*' * password.length})',
    );
    return isValid;
  }

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo/Title
                Icon(
                  Icons.person_pin_circle_outlined,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Gestión de Usuarios y Ciudades',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48.0),

                // Login Form
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Input del Email
                        AppTextField(
                          label: 'Correo Electrónico',
                          hintText: 'ejemplo@correo.com',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          onChanged: () {
                            setState(() {});
                            _authController.errorMessage.value = '';
                          },
                        ),
                        const SizedBox(height: 20.0),
                        //Input de la Contraseña
                        AppTextField(
                          label: 'Contraseña',
                          hintText: 'Ingresa tu contraseña',
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          onChanged: () {
                            setState(() {});
                            _authController.errorMessage.value = '';
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),

                // Login Button
                /*  Obx(() {
                  final isLoading = _authController.isLoading.value;
                  final isValid = _isFormValid();

                  //Boton Iniciar Sesion
                  return PrimaryButton(
                    text: 'Iniciar Sesión',
                    loading: isLoading,
                    enabled: isValid,
                    onPressed: _performLogin,
                  );                  
                }), */
                Obx(
                  () => PrimaryButton(
                    text: 'Iniciar Sesión',
                    onPressed: _isFormValid() ? _performLogin : null,
                    isLoading: _authController.isLoading.value,
                  ),
                ),
                // Debug Button (solo desarrollo)
                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    _emailController.text = 'jc@gmail.com';
                    _passwordController.text = '111111';
                    setState(() {});
                    AppLogger.info('✅ Credenciales de prueba establecidas');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: const Text('AUTORELLENAR (Prueba)'),
                ),

                // Error Message
                const SizedBox(height: 16.0),
                Obx(
                  () => _authController.errorMessage.value.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.red[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red[600]),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  _authController.errorMessage.value,
                                  style: TextStyle(
                                    color: Colors.red[600],
                                    fontSize: 14,
                                  ),
                                ),
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
 */


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
              Icon(
                Icons.person_pin_circle_outlined,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),

              Text(
                'Gestión de Usuarios y Ciudades',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              Text(
                'Inicia sesión para continuar',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
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
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      onChanged: () {
                        setState(() {});
                        _authController.errorMessage.value = '';
                      },
                    ),
                    const SizedBox(height: 20),

                    AppTextField(
                      label: 'Contraseña',
                      hintText: 'Ingresa tu contraseña',
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                      isPassword: true,
                      onChanged: () {
                        setState(() {});
                        _authController.errorMessage.value = '';
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
                  onPressed: _isFormValid() ? _performLogin : null,
                  isLoading: _authController.isLoading.value,
                ),
              ),

              const SizedBox(height: 16),

              // AUTORELLENAR – Solo dev
              ElevatedButton(
                onPressed: () {
                  _emailController.text = 'jc@gmail.com';
                  _passwordController.text = '111111';
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('AUTORELLENAR (Prueba)'),
              ),

              const SizedBox(height: 16),

              // ERROR MESSAGE
              Obx(
                () => _authController.errorMessage.value.isNotEmpty
                    ? Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                color: Colors.red[600]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _authController.errorMessage.value,
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 14,
                                ),
                              ),
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
