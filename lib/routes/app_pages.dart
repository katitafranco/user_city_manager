import 'package:get/get.dart';
import 'package:user_city_manager/modules/auth/binding/auth_binding.dart';
import 'package:user_city_manager/modules/auth/pages/login_screen.dart';
import 'package:user_city_manager/modules/cities/binding/cities_binding.dart';
import 'package:user_city_manager/modules/cities/pages/city_detail_screen.dart';
import 'package:user_city_manager/modules/home/binding/home_binding.dart';
import 'package:user_city_manager/modules/users/pages/user_detail_page.dart';
import '../app/core/middlewares/auth_middleware.dart';
import '../modules/cities/pages/city_screen.dart';
import '../modules/home/pages/home_screen.dart';
import '../modules/users/binding/users_binding.dart';
import '../modules/users/controller/user_detail_logic.dart';
import '../modules/users/pages/users_page.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final routes = <GetPage>[
    /*
    ///Como no usaremos pantalla de bienvenida la comento
    // // 🚪 Entrada de la app
    GetPage(name: AppRoutes.ROOT, page: () => const AppEntryPage()),
 */
    // 🔐 Auth
    GetPage(
      name: AppRoutes.LoginPage,
      binding: AuthBinding(),
      page: () => const LoginScreenGetX(),
    ),
    GetPage(
      name: AppRoutes.CitiesPage,
      bindings: [CitiesBinding()],
      page: () => const CitiesPage(),
      middlewares: [AuthMiddleware()],
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 1100),
    ),
    GetPage(name: AppRoutes.CityDetailPage, page: () => CityDetailPage()),
    //
    GetPage(
      name: AppRoutes.HomeScreen,
      bindings: [HomeBinding()],
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()],
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // USERS LIST
    GetPage(
      name: AppRoutes.UsersPage,
      page: () => const UsersPage(),
      binding: UsersBinding(),
    ),

    // USER DETAIL (needs users + cities)
    /* GetPage(
      name: AppRoutes.UserDetailPage,
      page: () => const UserDetailPage(),
      bindings: [
        UsersBinding(),
        CitiesBinding(),
      ],
    ), */
    GetPage(
      name: AppRoutes.UserDetailPage,
      page: () => const UserDetailPage(),
      bindings: [
        UsersBinding(),
        CitiesBinding(),
        BindingsBuilder(() {
          Get.lazyPut(() => UserDetailLogic());
        }),
      ],
    ),
    // CITIES LIST
    GetPage(
      name: AppRoutes.CitiesPage,
      page: () => const CitiesPage(),
      binding: CitiesBinding(),
    ),
  ];
}
