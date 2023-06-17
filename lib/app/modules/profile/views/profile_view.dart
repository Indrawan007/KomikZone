import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/controllers/auth_controller.dart';
import 'package:komikzone/app/routes/app_pages.dart';

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
            Container(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: authC.user.value.photoUrl == "nomimage"
                    ? Image.asset("assets/images/logo.png")
                    : Image.network(authC.user.value.photoUrl!),
              ),
            ),
            Obx(() => Text("${authC.user.value.name}")),
            Text("${authC.user.value.email}"),
            GestureDetector(
                onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                child: Text("${authC.user.value.uid}")),
          ],
        ));
  }
}
