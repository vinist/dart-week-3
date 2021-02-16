import 'package:dw3_pizza_delivery_api/application/modules/menu/controller/menu_controller.dart';
import 'package:dw3_pizza_delivery_api/application/routers/i_router_configure.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

class MenuRouters implements IRouterConfigure {

  @override
  void configure(Router router) {
    router.mount('/menu/', GetIt.I.get<MenuController>().router);
  }

}