import 'package:dw3_pizza_delivery_app/helpers/loader_mixin.dart';
import 'package:dw3_pizza_delivery_app/helpers/messages_mixin.dart';
import 'package:dw3_pizza_delivery_app/helpers/rest_client.dart';
import 'package:dw3_pizza_delivery_app/repositories/user_repository.dart';
import 'package:dw3_pizza_delivery_app/view_models/register_user_input_model.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController with LoaderMixin, MessagesMixin {

  final UserRepository _userRepository;
  final _obscureTextPassword = true.obs;
  final _obscureConfirmTextPassword = true.obs;

  final _loading = false.obs;
  final _message = Rx<MessageModel>();

  RegisterController(this._userRepository);

  get obscureTextPassword => _obscureTextPassword.value;
  get obscureConfirmTextPassword => _obscureConfirmTextPassword.value;

  void showHidePassword() => _obscureTextPassword.toggle();
  void showHideConfirmPassword() => _obscureConfirmTextPassword.toggle();

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }


  void registerUser(String name, String email, String password) async {
    try {
      _loading(true);
      _message(null);
      final inputModel = RegisterUserInputModel(
              name: name,
              email: email,
              password: password
          );
      await _userRepository.saveUser(inputModel);
      _loading(false);
      _message(MessageModel('Sucesso', 'Usuário cadastraro com sucesso', MessageType.info));

      await 2.seconds.delay();
      Get.close(2);
    } on RestClientException catch (e) {
      print(e);
      _loading(false);
      _message(MessageModel('Erro', e.message, MessageType.error));
    } catch(e) {
      print(e);
      _loading(false);
      _message(MessageModel('Erro', 'Erro ao registrar usuário', MessageType.error));
    }
  }
}