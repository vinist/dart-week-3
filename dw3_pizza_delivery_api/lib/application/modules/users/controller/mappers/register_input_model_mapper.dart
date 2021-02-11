import 'package:dw3_pizza_delivery_api/application/modules/users/view_modules/register_input_model.dart';

class RegisterInputModelMapper {

  final Map<String, dynamic> _requestMap;


  RegisterInputModelMapper(this._requestMap);

  RegisterInputModel mapper() {
    return RegisterInputModel(
      email: _requestMap['email'],
      name: _requestMap['name'],
      password: _requestMap['password'],
    );
  }

}
