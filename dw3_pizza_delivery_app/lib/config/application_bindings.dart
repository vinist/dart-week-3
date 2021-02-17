import 'package:dw3_pizza_delivery_app/helpers/rest_client.dart';
import 'package:get/get.dart';

class ApplicationBingings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => RestClient(), fenix: true);
  }

}