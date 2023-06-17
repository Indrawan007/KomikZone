import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/controllers/auth_controller.dart';
import 'package:komikzone/app/data/model/comics.dart';
import 'package:komikzone/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Row(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text("${authC.user.value.email}"),
              ],
            ),
            IconButton(
                onPressed: () => authC.logout(), icon: Icon(Icons.logout))
          ],
        ),
        leadingWidth: double.infinity,
        elevation: 0,
      ),
      body: FutureBuilder<List<Comics>>(
        future: controller.getAllComics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print(snapshot.data);
          if (!snapshot.hasData) {
            return Text("Tidak ada data.");
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Comics komik = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_COMICS, arguments: komik);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${komik.thumbnail}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${komik.title}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text("${komik.description}"),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "New Chapter ${komik.latestChapter}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
