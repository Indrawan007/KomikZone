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
        leading: IconButton(
          onPressed: () => Get.toNamed(Routes.HOME),
          icon: Icon(Icons.arrow_back),
        ),
        elevation: 0,
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.PROFILE),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: authC.user.value.photoUrl == "nomimage"
                                  ? Image.asset("assets/images/logo.png")
                                  : Image.network(authC.user.value.photoUrl!),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              "${authC.user.value.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Text("${authC.user.value.email}"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MyCont(
                  text: "Favorite",
                  iconData: Icons.favorite,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  focusColor: Colors.black,
                  splashColor: Colors.blue,
                  hoverColor: Colors.blue,
                  child: MyCont(
                    text: "Change Profile",
                    iconData: Icons.change_circle_outlined,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.FAVORITE),
                  child: MyCont(
                    text: "Favorite",
                    iconData: Icons.settings,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyCont(
                  text: "Night Mode",
                  iconData: Icons.wb_sunny_outlined,
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: MyCont(
                    text: "Sign Out",
                    iconData: Icons.logout_outlined,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCont extends StatelessWidget {
  final IconData iconData;
  final String text;
  const MyCont({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(iconData),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
