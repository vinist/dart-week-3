import 'dart:convert';

import 'package:dw3_pizza_delivery_api/application/modules/orders/controllers/mapper/save_order_input_model_mapper.dart';
import 'package:dw3_pizza_delivery_api/application/services/orders/i_orders_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'orders_controller.g.dart';

@Injectable()
class OrdersController {

  final IOrdersService _ordersService;

  OrdersController(this._ordersService);

  @Route.post('/')
  Future<Response> saveOrder(Request request) async {
    try {
      final inputModel = SaveOrderInputModelMapper(await request.readAsString());
      await _ordersService.saveOrder(inputModel.mapper());
      return Response.ok('');

    } catch (e) {
      print(e);
      return Response.internalServerError(body: jsonEncode({'message': 'Erro ao salvar order'}));
    }

  }

  @Route.get('/user/<userId>')
  Future<Response> find(Request request, String userId) async {
    try {
      final orders = await _ordersService.findMyOrders(int.parse(userId));
      final orderResponse = orders.map((e) => e.toMap()).toList();

      return Response.ok(jsonEncode(orderResponse));

    } catch (e) {
      print(e);
      return Response.internalServerError(body: jsonEncode({'message': 'Erro ao buscar orders'}));
    }

  }

  Router get router => _$OrdersControllerRouter(this);
}

