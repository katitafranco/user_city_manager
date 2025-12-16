import 'package:get/get.dart';
import '../controller/cities_create_logic.dart';

class CityCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CityCreateLogic());
  }
}
