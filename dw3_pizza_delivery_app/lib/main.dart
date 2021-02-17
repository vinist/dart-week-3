import 'package:dw3_pizza_delivery_app/app/config/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: UiConfig.appTheme,
      getPages: UiConfig.routes,
    );
  }
}
