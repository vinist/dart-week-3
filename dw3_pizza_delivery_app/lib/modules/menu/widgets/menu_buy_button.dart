import 'package:dw3_pizza_delivery_app/helpers/utils.dart';
import 'package:dw3_pizza_delivery_app/modules/menu/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuBuyButton extends GetView<MenuController> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: [
          SizedBox(
            width: Get.mediaQuery.size.width * .5,
            child: Obx(() => Text(
                  'Total R\$ ${Utils.formatter.format(controller.totalValue)}',
                    style: TextStyle(
                    fontSize: 18,
                    color: controller.flavorsSelected.isEmpty ? Colors.grey : Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Obx(() => TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      controller.flavorsSelected.isEmpty ? Colors.grey[200] : Colors.red
                  ),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Fechar Pedido',
                    style: TextStyle(
                        fontSize: 18,
                        color: controller.flavorsSelected.isEmpty ? Colors.grey : Colors.white
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}