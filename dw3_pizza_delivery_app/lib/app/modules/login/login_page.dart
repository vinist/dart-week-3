import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginPage> {

  static const String ROUTE_PAGE = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login'),),
      body: Container(),
    );
  }

}