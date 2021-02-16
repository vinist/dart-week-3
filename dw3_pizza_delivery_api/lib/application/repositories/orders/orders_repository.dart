import 'package:dw3_pizza_delivery_api/application/database/i_database_connection.dart';
import 'package:dw3_pizza_delivery_api/application/entities/menu_item.dart';
import 'package:dw3_pizza_delivery_api/application/entities/order.dart';
import 'package:dw3_pizza_delivery_api/application/entities/order_item.dart';
import 'package:dw3_pizza_delivery_api/application/exceptions/database_error_exception.dart';
import 'package:dw3_pizza_delivery_api/application/modules/orders/view_models/save_order_input_model.dart';
import 'package:dw3_pizza_delivery_api/application/repositories/orders/i_orders_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

@LazySingleton(as: IOrdersRepository)
class OrdersRepository implements IOrdersRepository {

  final IDatabaseConnection _connection;

  OrdersRepository(this._connection);

  @override
  Future<void> saveOrder(SaveOrderInputModel saveOrder) async {
    final conn = await _connection.openConnection();
    try {

      await conn.transaction((_) async {
            final resultOrder = await conn.query('insert into pedido(id_usuario, forma_pagamento, endereco_entrega) values (?,?,?)',
            [ saveOrder.userId,
              saveOrder.paymentType,
              saveOrder.address
            ]);

            final orderId = resultOrder.insertId;

            await conn.queryMulti('insert into pedido_item(id_pedido, id_cardapio_grupo_item) values (?,?)',
              saveOrder.itemsId.map((e) => [orderId, e]));
          });
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao inserir order');
    } finally {
      await conn?.close();
    }

  }

  @override
  Future<List<Order>> findMyOrders(int userId) async {
    final conn = await _connection.openConnection();
    final orders = <Order> [];

    try {
      final ordersResult = await conn.query('select * from pedido where id_usuario = ?', [userId]);

      if(ordersResult.isNotEmpty){

        for (var o in ordersResult) {
          final data = o.fields;

          final orderItemsResult = await conn.query('''
              select pi.id_pedido_item, cgi.id_cardapio_grupo_item, cgi.nome, cgi.valor
              from pedido_item pi
              join cardapio_grupo_item cgi on pi.id_cardapio_grupo_item = cgi.id_cardapio_grupo_item
              where pi.id_pedido = ? 
          ''', [data['id_pedido']]);
          
          final items = orderItemsResult.map<OrderItem>((item) {
            final itemFields = item.fields;
            return OrderItem(
              id: itemFields['id_pedido_item'],
              item: MenuItem(
                id: itemFields['id_cardapio_grupo_item'] as int,
                name: itemFields['nome'],
                price: itemFields['valor'],
              )
            );
          }).toList();

          final order = Order(
            id: data['id_pedido'] as int,
            address: (data['endereco_entrega'] as Blob).toString(),
            paymentType: data['forma_pagamento'] as String,
            items: items
          );
          orders.add(order);
        }
      }

      return orders;

    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao buscar orders');
    } finally {
      await conn?.close();
    }

  }
}