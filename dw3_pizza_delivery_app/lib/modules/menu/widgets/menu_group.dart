import 'package:dw3_pizza_delivery_app/helpers/utils.dart';
import 'package:dw3_pizza_delivery_app/models/menu_model.dart';
import 'package:dw3_pizza_delivery_app/modules/menu/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MenuGroup extends GetView<MenuController> {

  final MenuModel _menu;


  MenuGroup(this._menu);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Text(
              _menu.name,
              style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Divider(),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _menu.itens.length,
          itemBuilder: (_, index) {
            final item =  _menu.itens[index];
            return ListTile(
              title: Text(
                item.name,
                style: TextStyle(
                    color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13
                ),
              ),
              subtitle: Text(
                'R\$ ${Utils.formatter.format(item.price)}',
                style: TextStyle(fontSize: 13),
              ),
              trailing: Obx(() {
                final itemSelected = controller.flavorsSelected.contains(item);
                return IconButton(
                  icon: Icon(
                    itemSelected ? FontAwesome.minus_square : FontAwesome.plus_square,
                    color: Get.theme.primaryColor,
                    size: 20,
                  ),
                  onPressed: () => controller.addItem(item),
                );
                },
              ),
            );
          }
        )
      ],
    );
  }
}
