import 'package:get/get.dart';

import '../modules/chapter/bindings/chapter_binding.dart';
import '../modules/chapter/views/chapter_view.dart';
import '../modules/detail_comics/bindings/detail_comics_binding.dart';
import '../modules/detail_comics/views/detail_comics_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/regist/bindings/regist_binding.dart';
import '../modules/regist/views/regist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_COMICS,
      page: () => DetailComicsView(),
      binding: DetailComicsBinding(),
    ),
    GetPage(
      name: _Paths.CHAPTER,
      page: () => ChapterView(),
      binding: ChapterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGIST,
      page: () => const RegistView(),
      binding: RegistBinding(),
    ),
  ];
}
