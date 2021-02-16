import 'package:dw3_pizza_delivery_api/application/entities/order.dart';
import 'package:dw3_pizza_delivery_api/application/modules/orders/view_models/save_order_input_model.dart';

abstract class IOrdersService {

  Future<void> saveOrder(SaveOrderInputModel saveOrder);

  Future<List<Order>> findMyOrders(int userId);
}