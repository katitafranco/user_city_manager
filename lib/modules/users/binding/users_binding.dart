
import 'package:get/get.dart';
import '../controller/users_logic.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersLogic());
  }
}
 