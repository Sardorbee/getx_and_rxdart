import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_and_rxdart/data/rx_dart/multiplication_controller.dart';
import 'package:getx_and_rxdart/ui/tab_screen.dart';

void main() {
  final controller = MultiplicationController();
  runApp(MyApp(
    controller: controller,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.controller});
  final MultiplicationController controller;


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: TabScreen(controller: controller),
    );
  }
}
