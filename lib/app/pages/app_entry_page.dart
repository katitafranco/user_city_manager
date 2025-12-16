import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../utils/storage_helper.dart';
class AppEntryPage extends StatelessWidget {
  const AppEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() async {
      final isLoggedIn = StorageHelper.isLoggedIn();

      if (isLoggedIn) {
        Get.offAllNamed(AppRoutes.HomeScreen);
      } else {
        Get.offAllNamed(AppRoutes.LoginPage);
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
