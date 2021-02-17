import 'dart:convert';

import 'package:dw3_pizza_delivery_app/models/menu_item_model.dart';

class MenuModel {
  final int id;
  final String name;
  final List<MenuItemModel> itens;

  MenuModel({this.id, this.name, this.itens});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'itens': itens?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return MenuModel(
      id: map['id'],
      name: map['name'],
      itens: List<MenuItemModel>.from(map['itens']?.map((x) => MenuItemModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) => MenuModel.fromMap(json.decode(source));
}
