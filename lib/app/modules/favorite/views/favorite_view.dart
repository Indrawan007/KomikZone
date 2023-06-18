import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavoriteView'),
        centerTitle: true,
      ),
      body: GetBuilder<FavoriteController>(
        builder: (c) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: c.getFavorite(),
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text("${index + 1}"),
                    ),
                    title: Text("${data['comic']}"),
                    subtitle: Text("${data['chapter']}"),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
