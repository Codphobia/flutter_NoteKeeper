import 'dart:io';
import 'package:notekeeper/model/note_keeper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/noteKeeper.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE tbl_noteKeeper (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  title TEXT,
                  subTitle TEXT,
                  description TEXT)
    
    ''');
  }

  // Fetch operation: Get all Student objects from database

  Future<int> insertNoteKeeperRecord(NoteKeeper noteKeeper) async {
    Database db = await instance.database;
    int result = await db.insert('tbl_noteKeeper', noteKeeper.toMap());
    return result;
  }

  Future<List<NoteKeeper>> getAllRecord() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> list = await db.query('tbl_noteKeeper');
    List<NoteKeeper> noteKeepers = [];
    for (Map<String, dynamic> map in list) {
      NoteKeeper nk = NoteKeeper.fromMap(map);
      noteKeepers.add(nk);
    }
    return noteKeepers;
  }

  Future<int> updateNoteKeeperRecord(NoteKeeper noteKeeper) async {
    Database db = await instance.database;
    return await db.update('tbl_noteKeeper', noteKeeper.toMap(),
        where: 'id=?', whereArgs: [noteKeeper.id]);
  }

  Future<int> deleteNoteKeeperRecord(int id) async {
    Database db = await instance.database;
    return await db.delete('tbl_noteKeeper', where: 'id=?', whereArgs: [id]);
  }
}
