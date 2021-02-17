import 'package:dw3_pizza_delivery_app/helpers/loader_mixin.dart';
import 'package:dw3_pizza_delivery_app/helpers/messages_mixin.dart';
import 'package:dw3_pizza_delivery_app/helpers/rest_client.dart';
import 'package:dw3_pizza_delivery_app/modules/splash/splash_page.dart';
import 'package:dw3_pizza_delivery_app/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {

  final _obscureText = true.obs;
  final UserRepository _repository;
  final _loading = false.obs;
  final _message = Rx<MessageModel>();

  LoginController(this._repository);

  @override
  void onInit() {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }

  get obscureText => _obscureText.value;

  void showHidePassword() => _obscureText.toggle();

  void login(String email, String password) async {
    try {
      _loading(true);
      _message(null);
      final user = await _repository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('user', user.toJson());
      _loading(false);
      Get.offAndToNamed(SplashPage.ROUTE_PAGE);
    } on RestClientException catch (e) {
      print(e);
      _loading(false);
      _message(MessageModel('Erro', e.message, MessageType.error));

    } catch (e) {
      print(e);
      _loading(false);
      _message(MessageModel('Erro', 'Erro ao autenticar usuário', MessageType.error));
    }
  }

}