import 'package:dw3_pizza_delivery_api/application/database/i_database_connection.dart';
import 'package:dw3_pizza_delivery_api/application/entities/user.dart';
import 'package:dw3_pizza_delivery_api/application/exceptions/database_error_exception.dart';
import 'package:dw3_pizza_delivery_api/application/exceptions/user_not_found_exception.dart';
import 'package:dw3_pizza_delivery_api/application/modules/users/view_modules/register_input_model.dart';
import 'package:dw3_pizza_delivery_api/application/modules/users/view_modules/user_login_model.dart';
import 'package:dw3_pizza_delivery_api/application/repositories/user/i_user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection _connection;

  UserRepository(this._connection);

  @override
  Future<void> saveUser(RegisterInputModel model) async {
    final conn = await _connection.openConnection();

    try {
      await conn.query('insert into usuario(nome, email, senha) values (?,?,?)',
          [model.name, model.email, model.password]);
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao registrar o usuário');
    } finally {
      await conn?.close;
    }
  }

  @override
  Future<User> login(UserLoginModel viewModel) async {
    final conn = await _connection.openConnection();

    try {
      final result = await conn.query('''
        select *
        from usuario
        where email = ?
        and senha = ?
        ''', [viewModel.email, viewModel.password]);

      if (result.isEmpty) {
        throw UserNotFoundException();
      }

      final row = result.first;
      return User(
        email: row['email'] as String,
        id: row['id_usuario'] as int,
        name: row['nome'] as String,
        password: row['senha'] as String,
      );
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseErrorException(message: 'Erro ao buscar o usuário');
    } finally {
      await conn?.close;
    }
  }
}
