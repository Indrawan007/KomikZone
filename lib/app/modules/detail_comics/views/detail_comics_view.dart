import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/data/model/comics.dart';
import 'package:komikzone/app/data/model/details.dart';
import 'package:komikzone/app/modules/login/views/login_view.dart';
import 'package:komikzone/app/routes/app_pages.dart';

import '../controllers/detail_comics_controller.dart';

class DetailComicsView extends GetView<DetailComicsController> {
  DetailComicsView({Key? key}) : super(key: key);

  final Comics comic = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('DetailComicsView'),
        centerTitle: true,
      ),
      body: FutureBuilder<Details>(
        future: controller.getDetailsComics(comic.param.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Text("Tidak ada data.");
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    Details detail = snapshot.data!;
                    // var total = snapshot.data!.chapters!.length;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${detail.title?.substring(6)}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                width: 200,
                                child: Image.network(
                                  "${detail.thumbnail}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // Column(
                              //   children: [
                              //     Text("Chapter Awal"),
                              //     ElevatedButton(
                              //       style: ElevatedButton.styleFrom(
                              //         minimumSize: Size(130, 30),
                              //       ),
                              //       onPressed: () {
                              //         Get.toNamed(Routes.CHAPTER,
                              //             arguments: detail
                              //                 .chapters![total - 1].param);
                              //       },
                              //       child: Text(
                              //           "${detail.chapters![total - 1].chapter}"),
                              //     ),
                              //     Text("Chapter Akhir"),
                              //     ElevatedButton(
                              //       style: ElevatedButton.styleFrom(
                              //         minimumSize: Size(130, 30),
                              //       ),
                              //       onPressed: () {
                              //         Get.toNamed(Routes.CHAPTER,
                              //             arguments:
                              //                 detail.chapters![index].param);
                              //       },
                              //       child: Text(
                              //           "${detail.chapters![index].chapter}"),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${detail.synopsis}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.chapters!.length,
                  itemBuilder: (context, index) {
                    Details detail = snapshot.data!;
                    return Card(
                      child: ListTile(
                        onTap: () {
                          authC.addFavorite(true, snapshot.data!, index);
                          Get.toNamed(Routes.CHAPTER,
                              arguments: detail.chapters![index].param);
                        },
                        title: Text(
                          "${detail.chapters![index].chapter}",
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              authC.addFavorite(false, snapshot.data!, index);
                            },
                            icon: Icon(Icons.favorite)),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
