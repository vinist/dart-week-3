import 'package:dw3_pizza_delivery_api/application/modules/orders/controllers/orders_controller.dart';
import 'package:dw3_pizza_delivery_api/application/routers/i_router_configure.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/src/router.dart';

class OrdersRouter implements IRouterConfigure {

  @override
  void configure(Router router) {
    router.mount('/order/', GetIt.I.get<OrdersController>().router);
  }

}