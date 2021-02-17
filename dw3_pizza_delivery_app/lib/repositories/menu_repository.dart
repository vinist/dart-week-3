import 'package:dw3_pizza_delivery_app/helpers/rest_client.dart';
import 'package:dw3_pizza_delivery_app/models/menu_model.dart';

class MenuRepository {

  final RestClient _restClient;

  MenuRepository(this._restClient);

  Future<List<MenuModel>> findAll() async {
    final response = await _restClient.get<List<MenuModel>>('/menu/', decoder: (resp) {
      if(resp is List){
        return resp.map<MenuModel>((m) => MenuModel.fromMap(m)).toList();
      }
      return null;
    });

    if(response.hasError){
      throw RestClientException('Erro ao buscar cardápio');
    }

    return response.body;
  }
}