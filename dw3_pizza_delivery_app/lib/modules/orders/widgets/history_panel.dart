import 'package:dw3_pizza_delivery_app/helpers/utils.dart';
import 'package:dw3_pizza_delivery_app/models/order_model.dart';
import 'package:flutter/material.dart';

class HistoryPanel extends StatelessWidget {

  final OrderModel order;

  HistoryPanel(this.order);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text('Pedido ${order.id}'),
        children: [
          Divider(),
          ...order.items.map((e){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.item.name),
                  Text('R\$ ${Utils.formatter.format(e.item.price)}')
                ],
              ),
            );
          }).toList(),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Total'),
                Text('R\$ ${Utils.formatter.format(_calculateTotalOrder())}')
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
    );
  }

  _calculateTotalOrder() => order.items.fold(0, (total, o) => total+= o.item.price);
}
