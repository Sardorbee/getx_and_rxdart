import 'package:get/get.dart';

class IndexedStackController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int newIndex) {
    currentIndex.value = newIndex;
  }
}
