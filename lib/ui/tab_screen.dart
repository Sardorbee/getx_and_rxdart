import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_and_rxdart/data/getx/tab_controller.dart';
import 'package:getx_and_rxdart/ui/dictionary_screen/dictionary_screen.dart';
import 'package:getx_and_rxdart/ui/reactive_screen/reactive_screen.dart';
import 'package:getx_and_rxdart/data/rx_dart/multiplication_controller.dart';

class TabScreen extends StatelessWidget {
  TabScreen({super.key, required this.controller});
  final MultiplicationController controller;
  final IndexedStackController indexedStackController =
      Get.put(IndexedStackController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: indexedStackController.currentIndex.value,
          children: [
            DictionaryScreen(),
            ReactiveScreen(controller: controller),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: indexedStackController.currentIndex.value,
          onTap: (value) => indexedStackController.changeIndex(value),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'dictionary'),
            BottomNavigationBarItem(
                icon: Icon(Icons.numbers), label: 'reactive')
          ],
        ),
      ),
    );
  }
}
