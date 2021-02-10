import 'package:dw3_pizza_delivery_api/application/config/database_connection_config.dart';
import 'package:dw3_pizza_delivery_api/application/database/i_database_connection.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/src/single_connection.dart';

@Injectable(as: IDatabaseConnection)
class DatabaseConnection implements IDatabaseConnection {

  final DatabaseConnectionConfig _connectionConfig;

  DatabaseConnection(this._connectionConfig);

  @override
  Future<MySqlConnection> openConnection() {
    MySqlConnection.connect(ConnectionSettings(
        host: _connectionConfig.host,
        port: int.parse(_connectionConfig.port),
        password: _connectionConfig.password,
        user: _connectionConfig.user,
        db: _connectionConfig.databaseName
      ));
  }
  

}