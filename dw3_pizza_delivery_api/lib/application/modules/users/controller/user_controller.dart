import 'dart:convert';

import 'package:dw3_pizza_delivery_api/application/exceptions/user_not_found_exception.dart';
import 'package:dw3_pizza_delivery_api/application/modules/users/controller/mappers/register_input_model_mapper.dart';
import 'package:dw3_pizza_delivery_api/application/modules/users/controller/mappers/user_login_view_model_mapper.dart';
import 'package:dw3_pizza_delivery_api/application/services/user/i_user_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'user_controller.g.dart';

@Injectable()
class UserController {

  final IUserService _service;

  UserController(this._service);

  @Route.post('/')
  Future<Response> register(Request request) async {
    try {
      final requestMap = jsonDecode(await request.readAsString());
      final inputModel = RegisterInputModelMapper(requestMap).mapper();

      await _service.register(inputModel);

      return Response.ok(jsonEncode({'message': 'Usuário criado com sucesso'}));  
    } catch (e) {
      print(e);
      return Response.internalServerError(
        body: jsonEncode(
          {
            'message': 'Erro ao registrar novo usuário',
          },
        ),
      );
    }
    
  }

  @Route.post('/auth')
  Future<Response> login(Request request) async {
    try {
      final requestMap = jsonDecode(await request.readAsString());
      final viewModel = UserLoginViewModelMapper(requestMap).mapper();
      final user = await _service.login(viewModel);

      return Response.ok(jsonEncode({
       'id': user.id,
       'name': user.name,
       'email': user.email
      }));

    } on UserNotFoundException catch (e) {
      print(e);
      return Response.forbidden('');
    } catch (e) {
      print(e);
      return Response.internalServerError(body: jsonEncode({'message': 'Erro interno'}));
    }
    
  }

  Router get router => _$UserControllerRouter(this);
}