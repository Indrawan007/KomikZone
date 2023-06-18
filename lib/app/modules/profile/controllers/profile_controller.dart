import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final white = Color.fromARGB(255, 255, 255, 255);
  final containerColor = Colors.white.obs;

  void changeColor() {
    containerColor.value =
        containerColor.value == Colors.white ? Colors.red : Colors.white;
  }
}
