import 'package:dw3_pizza_delivery_api/application/entities/order.dart';
import 'package:dw3_pizza_delivery_api/application/modules/orders/view_models/save_order_input_model.dart';

abstract class IOrdersRepository {

  Future<void> saveOrder(SaveOrderInputModel saverOrder);

  Future<List<Order>> findMyOrders(int userId);
}