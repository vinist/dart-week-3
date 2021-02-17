import 'package:get/get.dart';

class RestClient extends GetConnect {

  String baseUrl = "http://10.0.2.2:8080";

  RestClient() {
    httpClient.baseUrl = this.baseUrl;
  }

}

class RestClientException implements Exception {
  final int code;
  final String message;

  RestClientException(this.message, {this.code});

  @override
  String toString() {
    return 'RestClientException{code: $code, message: $message}';
  }
}