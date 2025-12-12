import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/utils/logger.dart';
import 'app/utils/storage_helper.dart';
import 'app/data/dio_client.dart';
import 'app/data/repositories/auth_repository.dart';
import 'modules/auth/controllers/auth_controller.dart';
import 'modules/auth/pages/login_screen.dart';
import 'modules/auth/pages/home_screen.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar storage
  await StorageHelper.init();
   AppLogger.info('✅ StorageHelper inicializado');

  
  // Registrar dependencias GLOBALES
  Get.put(DioClient(), permanent: true);
  Get.put(AuthRepository(), permanent: true);
  Get.put(AuthController(), permanent: true);
  
  AppLogger.info('✅ Dependencias registradas');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gestión Usuarios',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // NO usar initialBinding porque ya registramos arriba
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
      initialRoute: StorageHelper.isLoggedIn() ? '/home' : '/login',
    );
  }
}