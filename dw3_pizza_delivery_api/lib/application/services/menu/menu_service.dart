import 'package:dw3_pizza_delivery_api/application/entities/menu.dart';
import 'package:dw3_pizza_delivery_api/application/repositories/menu/i_menu_repository.dart';
import 'package:dw3_pizza_delivery_api/application/services/menu/i_menu_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IMenuService)
class MenuService implements IMenuService {

  final IMenuRepository _repository;

  MenuService(this._repository);

  @override
  Future<List<Menu>> getAllMenus() {
    return _repository.findAll();
  }

}