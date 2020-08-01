import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studen_db/models/student.dart';

//Local Api
class StudentDBProvider {
  StudentDBProvider._();

  static final StudentDBProvider db = StudentDBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "StudentDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Student ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "fathersName TEXT,"
          "city TEXT,"
          "phone TEXT,"
          "address TEXT,"
          "zip TEXT,"
          "dob TEXT"
          ")");
    });
  }

  deleteTable() async {
    final db = await database;
    await db.delete("Student");
  }

  Future<bool> saveStudent(Student student) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Student (id,name,fathersName,address,city,zip,phone,dob)"
        " VALUES (?,?,?,?,?,?,?,?)",
        [
          student.id,
          student.name,
          student.fathersName,
          student.address,
          student.city,
          student.zip,
          student.phone,
          student.dob
        ]);
    return true;
  }

  Future<List<Student>> getAllStudentsFromLocalDb() async {
    final db = await database;
    var res = await db.query("Student");
    List<Student> list =
        res.isNotEmpty ? res.map((c) => Student.fromMap(c)).toList() : [];

    return list;
  }

  Future<bool> deleteStudentFromLocalDb(String id) async {
    print('deleting for $id');
    final db = await database;
    db.delete("Student", where: "id = ?", whereArgs: [id]);
    return true;
  }

  Future<int> updateStudent(Map<String, dynamic> row, String id) async {
    final db = await database;
    return await db.update("Student", row, where: 'id = ?', whereArgs: [id]);
  }
}
