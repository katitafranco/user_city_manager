import 'package:get/get.dart';
import '../controller/home_logic.dart';

/// Binding del módulo Home.
/// Registra la lógica necesaria para la pantalla principal.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLogic>(() => HomeLogic());
  }
}
