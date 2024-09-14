// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:spareparts/navigationPages/Home/Home.dart';
import 'Home2.dart';
import 'HomeController.dart';
import 'TCircularContainer.dart';

class SlideWidget extends StatelessWidget {
  const SlideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, _) => controller.updatePageInicator(index),
            viewportFraction: 0.98,
            height: 341.0,
          ),
          items: [
            Homes2(
              searchQuery: '',
            ),
          ],
        ),
      ],
    );
  }
}
