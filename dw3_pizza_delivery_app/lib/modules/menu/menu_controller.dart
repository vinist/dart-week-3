import 'package:dw3_pizza_delivery_app/models/menu_item_model.dart';
import 'package:dw3_pizza_delivery_app/models/menu_model.dart';
import 'package:dw3_pizza_delivery_app/repositories/menu_repository.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {

  final MenuRepository _menuRepository;
  final _menu = <MenuModel>[].obs;
  final _flavorsSelected = <MenuItemModel>[].obs;

  List<MenuModel> get menu => _menu;
  List<MenuItemModel> get flavorsSelected => _flavorsSelected;
  double get totalValue => _flavorsSelected.fold(0, (value, item) => value+= item.price);

  MenuController(this._menuRepository);

  @override
  Future<void> onInit() async {
    super.onInit();
    final menuData = await _menuRepository.findAll();
    menu.assignAll(menuData);
  }

  void addItem(MenuItemModel item){
    if(_flavorsSelected.contains(item)){
      _flavorsSelected.remove(item);
    } else {
      _flavorsSelected.add(item);
    }
  }

}