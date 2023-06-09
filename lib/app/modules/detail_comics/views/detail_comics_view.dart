import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_comics_controller.dart';

class DetailComicsView extends GetView<DetailComicsController> {
  const DetailComicsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailComicsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailComicsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
