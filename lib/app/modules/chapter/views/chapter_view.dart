import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/data/model/allchapters.dart';

import '../controllers/chapter_controller.dart';

class ChapterView extends GetView<ChapterController> {
  ChapterView({Key? key}) : super(key: key);
  final detail = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<AllChapters>(
        future:
            controller.getAllChapters(detail.toString()) as Future<AllChapters>,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Text("Tidak ada data.");
          }
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.network("${snapshot.data!.data![index]}"),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
