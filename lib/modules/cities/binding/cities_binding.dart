import 'package:get/get.dart';

import '../controller/cities_logic.dart';

class CitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CitiesLogic>(
      () => CitiesLogic(),
      fenix: true,
    );
  }
}
