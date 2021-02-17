import 'package:dw3_pizza_delivery_app/helpers/utils.dart';
import 'package:dw3_pizza_delivery_app/modules/shoppingCard/shopping_card_controller.dart';
import 'package:dw3_pizza_delivery_app/modules/shoppingCard/widgets/shopping_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCardItems extends GetView<ShoppingCardController> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Pedido',
            style: TextStyle(
                fontSize: 16
            ),
          ),
        ),
        SizedBox(height: 10),
        ...controller.flavorsSelected.map((item) => ShoppingCardItem(item)).toList(),
        Divider(),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total'),
              Text('R\$ ${Utils.formatter.format(controller.totalPrice)}')
            ],
          ),
        ),
      ],
    );
  }
}
