import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/controllers/auth_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text("${authC.user.name}"),
            Text("${authC.user.email}"),
            Text("${authC.user.uid}"),
            Text("${authC.user.name}"),
            Text("${authC.user.name}"),
            Text("${authC.user.name}"),
            Text("${authC.user.name}"),
            Text("${authC.user.name}"),
          ],
        ));
  }
}
