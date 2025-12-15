import 'package:get/get.dart';
import '../../../app/data/dio_client.dart';
import '../../../app/data/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
