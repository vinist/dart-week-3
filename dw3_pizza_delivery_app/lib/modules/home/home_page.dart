import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePage> {

  static const String ROUTE_PAGE = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'),),
      body: Container(),
    );
  }

}