import 'package:get/get.dart';

import '../controllers/detail_comics_controller.dart';

class DetailComicsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailComicsController>(
      () => DetailComicsController(),
    );
  }
}
