import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cities_logic.dart';

class CitiesPage extends GetView<CitiesLogic> {
  const CitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
