import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/utils/logger.dart';
import '../../../app/widgets/app_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
                  color: Colors.blue[700],
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Gestión de Usuarios y Ciudades',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
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
                Obx(() {
                  final isLoading = _authController.isLoading.value;
                  final isValid = _isFormValid();

                  return ElevatedButton(
                    onPressed: isLoading || !isValid ? null : _performLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  );
                }),

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
}
