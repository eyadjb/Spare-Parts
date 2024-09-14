// ignore_for_file: file_names

import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final carousalCurrentIndex = 0.obs;
  void updatePageInicator(index) {
    carousalCurrentIndex.value = index;
  }
}
