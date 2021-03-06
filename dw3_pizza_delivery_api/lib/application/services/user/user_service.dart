import 'package:dw3_pizza_delivery_api/application/entities/user.dart';
import 'package:dw3_pizza_delivery_api/application/helpers/cripty_helper.dart';
import 'package:dw3_pizza_delivery_api/application/modules/users/view_modules/register_input_model.dart';
import 'package:dw3_pizza_delivery_api/application/modules/users/view_modules/user_login_model.dart';
import 'package:dw3_pizza_delivery_api/application/repositories/user/i_user_repository.dart';
import 'package:dw3_pizza_delivery_api/application/services/user/i_user_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {

  final IUserRepository _repository;

  UserService(this._repository);

  @override
  Future<void> register(RegisterInputModel inputModel) async {
    final passwordCrypt = CriptyHelper.generateSHA256Hash(inputModel.password);

    inputModel.password = passwordCrypt;
    await _repository.saveUser(inputModel);
  }

  @override
  Future<User> login(UserLoginModel viewModel) async {
    final passwordCrypt = CriptyHelper.generateSHA256Hash(viewModel.password);

    viewModel.password = passwordCrypt;

    return await _repository.login(viewModel);   
  }

}