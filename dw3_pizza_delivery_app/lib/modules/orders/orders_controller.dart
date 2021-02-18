import 'package:dw3_pizza_delivery_app/models/user_model.dart';
import 'package:dw3_pizza_delivery_app/repositories/order_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersController extends GetxController with StateMixin {
  final OrderRepository _orderRepository;
  UserModel _user;

  OrdersController(this._orderRepository);

  @override
  void onInit() async {
    super.onInit();
    final sp = await SharedPreferences.getInstance();
    _user = UserModel.fromJson(sp.getString('user'));
    findOrders();
  }

  void findOrders() async {
    change([], status: RxStatus.loading());
    try {
      final orders = await _orderRepository.findMyOrders(_user.id);
      change(orders, status: RxStatus.success());
    } catch (e) {
      change('Erro ao buscar pedidos', status: RxStatus.error());
    }
    
  }
}