import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikzone/app/data/model/comics.dart';
import '../controllers/searching_controller.dart';

class SearchingView extends GetView<SearchingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchingView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GetX<SearchingController>(
              init: SearchingController(),
              builder: (controller) => TextFormField(
                controller: controller.searchController,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  controller.searchBooks(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                ),
              ),
            ),
          ),
          Expanded(
            child: GetX<SearchingController>(
              init: SearchingController(),
              builder: (controller) {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      Comics comic = controller.searchResults[index];
                      return ListTile(
                        title: Text(comic.title ?? ''),
                        subtitle: Text(comic.description ?? ''),
                        leading: Image.network(comic.thumbnail ?? ''),
                        onTap: () {
                          // Tambahkan logika ketika item di-tap
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
