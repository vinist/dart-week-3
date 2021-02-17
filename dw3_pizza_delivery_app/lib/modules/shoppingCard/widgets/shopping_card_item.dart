import 'package:dw3_pizza_delivery_app/helpers/utils.dart';
import 'package:dw3_pizza_delivery_app/models/menu_item_model.dart';
import 'package:flutter/material.dart';

class ShoppingCardItem extends StatelessWidget {

  final MenuItemModel item;

  ShoppingCardItem(this.item, {Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.name),
          Text('R\$ ${Utils.formatter.format(item.price)}')
        ],
      ),
    );
  }
}
