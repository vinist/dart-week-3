import 'package:dw3_pizza_delivery_api/application/entities/order.dart';
import 'package:dw3_pizza_delivery_api/application/modules/orders/view_models/save_order_input_model.dart';
import 'package:dw3_pizza_delivery_api/application/repositories/orders/i_orders_repository.dart';
import 'package:dw3_pizza_delivery_api/application/services/orders/i_orders_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrdersService)
class OrdersService implements IOrdersService {

  final IOrdersRepository _repository;

  OrdersService(this._repository);

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    await _repository.saveOrder(saveOrder);
  }

  @override
  Future<List<Order>> findMyOrders(int userId) async {
    return await _repository.findMyOrders(userId);
  }

}