import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  final String _dbName = "orders.sqlite";

  static final SqliteHelper _instance = SqliteHelper._internal();

  SqliteHelper._internal() {
    _opDatabase2();
  }

  factory SqliteHelper() {
    return _instance;
  }

  Future<Database> od() async {
    return openDatabase(join(await getDatabasesPath(), _dbName));
  }

  Future<void> _opDatabase2() async {
    String dbPath = join(await getDatabasesPath(), _dbName);

    if (await databaseExists(dbPath)) {
      log("Veritabanı mevcut. Koplayalamaya gerek yok.");
    } else {
      ByteData bytes = await rootBundle.load("database/$_dbName");
      List<int> list =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      await File(dbPath).writeAsBytes(list, flush: true);
      log("Veritabanı kopyalandı.");
    }
    log(dbPath);
  }
}
