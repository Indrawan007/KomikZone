import 'package:get/get.dart';
import 'package:komikzone/app/data/db/favorite.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteController extends GetxController {
  DatabaseManager database = DatabaseManager.instance;

  Future<List<Map<String, dynamic>>> getFavorite() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allFavorite =
        await db.query("favorite", where: "last_read == 0");
    return allFavorite;
  }
}
