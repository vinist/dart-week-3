import 'package:dw3_pizza_delivery_app/app/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(LoginController());
  }
}