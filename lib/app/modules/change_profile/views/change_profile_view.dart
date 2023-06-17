import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/controllers/auth_controller.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.nameC.text = authC.user.value.name!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text('ChangeProfileView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authC.changeProfile(controller.nameC.text);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: authC.user.value.photoUrl == "nomimage"
                    ? Image.asset("assets/images/logo.png")
                    : Image.network(authC.user.value.photoUrl!),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller.nameC,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              authC.changeProfile(controller.nameC.text);
            },
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                authC.changeProfile(controller.nameC.text);
              },
              child: Text(""))
        ],
      ),
    );
  }
}
