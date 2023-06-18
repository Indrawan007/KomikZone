import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  DatabaseManager._private();

  static DatabaseManager instance = DatabaseManager._private();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDB();
    }

    return _db!;
  }

  Future _initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();

    String path = join(docDir.path, "favorite.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute('''
          CREATE TABLE favorite (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            comic TEXT NOT NULL,
            thumbnail TEXT NOT NULL,
            detail TEXT NOT NULL,
            chapter TEXT NOT NULL,
            via TEXT NOT NULL,
            index INTEGER NOT NULL,
            last_read INTEGER DEFAULT 0
          )
          ''');
      },
    );
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
