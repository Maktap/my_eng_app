import 'dart:io';

import 'package:flutter/services.dart';
import 'package:my_eng_app/utils/kelimeler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }
  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initDatabase() async {
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasePath = await getDatabasesPath();
          var path = join(databasePath, "myWords.db");
          var file = new File(path);

          //check if file exists
          if (!await file.exists()) {
            //copy from assets
            ByteData data =
                await rootBundle.load(join("assets", "ingilizce.db"));            
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          //opern databse
          _db = await openDatabase(path);
        }
      });
    }
    return _db;
  }

Future<List<Map<String, dynamic>>> kelimeleriGetir() async {
    Database db = await _getDatabase();    
    return await db.query('kelimeler');
  }

  Future<int> kelimeleriINSERT(Kelimeler kelime) async {
    Database db = await _getDatabase();
    return await db.insert('kelimeler', kelime.toMap());
  }

  Future<int> kelimeleriUPDATE(Kelimeler kelime) async {
    Database db = await _getDatabase();
    return await db.update('kelimeler', kelime.toMap(),
        where: 'id = ?', whereArgs: [kelime.getKelimeID]);
  }

  Future<int> kelimeleriDELETE(int id) async {
    Database db = await _getDatabase();
    return await db
        .delete('kelimeler', where: 'id = ?', whereArgs: [id]);
  }

  kelimeTabloSil() async{
    Database db = await _getDatabase();
    return db.delete('kelimeler');
  }

}
