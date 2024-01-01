import 'dart:async';
import 'optimized_student_form_details.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const dataBaseName = 'studentDetailsDB.db';
  static const dataBaseVersion = 1;
  static const dataBaseTableName = '_studentDetailsTable';

  static const columnId = '_id';
  static const columnStudentName = '_studentName';
  static const columnStudentMobNo = '_mobileNo';
  static const columnStudentId = '_emailId';
  static const columnStudentAddress = '_address';

  late Database _db;

  Future<void> initialization() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dataBaseName);

    _db = await openDatabase(
      path,
      version: dataBaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $dataBaseTableName (
      $columnId INTEGER PRIMARY KEY,
      $columnStudentName TEXT,
      $columnStudentMobNo TEXT,
      $columnStudentId TEXT NULL,
      $columnStudentAddress TEXT
      )
   ''');
  }

  Future _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    await database.execute('DROP TABLE $dataBaseTableName');
    _onCreate(database, newVersion);
  }
//insert
  Future<int> insertStudentDetails(Map<String, dynamic> row) async {
    return await _db.insert(dataBaseTableName, row);
  }
//display
  Future<List<Map<String,dynamic>>> getStudentDetails() async{
    return await _db.query(dataBaseTableName);

  }

  Future<int> updateStudentDetails(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(
      dataBaseTableName,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteStudentDetails(int id) async {
    return await _db.delete(
      dataBaseTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
