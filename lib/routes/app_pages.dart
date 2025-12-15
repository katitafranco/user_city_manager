import 'package:get/get.dart';
import 'package:user_city_manager/modules/auth/binding/auth_binding.dart';
import 'package:user_city_manager/modules/auth/pages/login_screen.dart';
import 'package:user_city_manager/modules/cities/binding/cities_binding.dart';

import '../modules/auth/pages/home_screen.dart';
import '../modules/cities/pages/cities_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.ROOT,
      binding: AuthBinding(),
      page: () => const LoginScreenGetX(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1100),
    ),
    GetPage(
      name: AppRoutes.CitiesPage,
      bindings: [CitiesBinding()],
      page: () => const CitiesPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1100),
    ),
    // 
    GetPage(
      name: AppRoutes.HomePage,
      page: () => HomeScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
