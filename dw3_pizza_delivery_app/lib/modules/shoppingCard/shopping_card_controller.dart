import 'package:dw3_pizza_delivery_app/helpers/loader_mixin.dart';
import 'package:dw3_pizza_delivery_app/helpers/messages_mixin.dart';
import 'package:dw3_pizza_delivery_app/models/menu_item_model.dart';
import 'package:dw3_pizza_delivery_app/models/user_model.dart';
import 'package:dw3_pizza_delivery_app/repositories/order_repository.dart';
import 'package:dw3_pizza_delivery_app/view_models/checkout_input_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCardController extends GetxController with MessagesMixin, LoaderMixin {
  final OrderRepository _orderRepository;
  final RxList<MenuItemModel> flavorsSelected;
  final _user = Rx<UserModel>();
  final _address = ''.obs;
  final _paymentType = ''.obs;
  final addressEditingControler = TextEditingController();
  final _message = Rx<MessageModel>();
  final _loading = false.obs;

  String get userName => _user.value?.name;
  double get totalPrice => flavorsSelected.fold(0, (total, item) => total+= item.price);
  String get address => _address.value;
  String get paymentType => _paymentType.value;


  ShoppingCardController(this._orderRepository, this.flavorsSelected);

  @override
  void onInit() async {
    super.onInit();
    messageListener(_message);
    loaderListener(_loading);
    final sp = await SharedPreferences.getInstance();
    _user(UserModel.fromJson(sp.getString('user')));
  }

  void changeAddress() async {
    await Get.defaultDialog(
      title: 'Endereço de Entrega',
      content: TextField(
        controller: addressEditingControler,
      ),
      cancel: RaisedButton(
        color: Get.theme.primaryColor,
        onPressed: () => Get.back(),
        textColor: Colors.white,
        child: Text('Cancelar'),
      ),
      confirm: RaisedButton(
        color: Get.theme.primaryColor,
        onPressed: () {
          _address(addressEditingControler.text);
          addressEditingControler.clear();
          Get.back();
        },
        textColor: Colors.white,
        child: Text('Alterar'),
      )
    );
  }

  void changePaymentType() async {
    await Get.defaultDialog(
        title: 'Forma de Pagamento',
        content: Container(
          height: 150,
          child: RadioButtonGroup(
            labels: [
              'Cartão de Crédito',
              'Cartão de Débito',
              'Dinheiro',
            ],
            onSelected: (String value) => _paymentType(value),
          ),
        ),
        cancel: RaisedButton(
          color: Get.theme.primaryColor,
          onPressed: () => Get.back(),
          textColor: Colors.white,
          child: Text('Cancelar'),
        ),
        confirm: RaisedButton(
          color: Get.theme.primaryColor,
          onPressed: () {
            Get.back();
          },
          textColor: Colors.white,
          child: Text('Alterar'),
        )
    );
  }

  void checkout() async {
    if(address.isBlank) {
      _message(MessageModel('Erro', 'Endereço de entrega obrigatório', MessageType.error));
    } else if(paymentType.isBlank) {
      _message(MessageModel('Erro', 'Forma de pagamento obrigatória', MessageType.error));
    } else {
      try {
        _loading(true);
        await _orderRepository.saveOrder(CheckoutInputModel(
            userId: _user.value.id,
            address: address,
            paymentType: paymentType,
            itemsId: flavorsSelected.map<int>((f)=> f.id).toList()
        ));

        _loading(false);
        _message(MessageModel('Sucesso', 'Pedido Realizado com Sucesso', MessageType.info));
        await 2.seconds.delay();
        Get.close(3);
      } catch (e) {
        print(e);
        _loading(false);
        _message(MessageModel('Erro', 'Erro ao registrar pedido', MessageType.error));
      }
    }
  }

}
