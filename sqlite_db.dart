import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BMIRecord {
  static const String _dbName = "bitp3453_bmi";
  static const String _tblName = "bmi";
  static const String _colUsername = "username";
  static const String _colWeight = "weight";
  static const String _colHeight = "height";
  static const String _colGender = "gender";
  static const String _colStatus = "bmi_status";

  Database? _db;

  BMIRecord._(); // private constructor
  static final BMIRecord instance = BMIRecord._();

  factory BMIRecord() {
    return instance;
  }

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    String path = join(await getDatabasesPath(), _dbName);
    _db = await openDatabase(path, version: 1, onCreate: (createdDb, version) async {
      for (String tableSql in BMIRecord.tableSQLStrings) {
        await createdDb.execute(tableSql);
      }
    });
    return _db!;
  }

  static List<String> tableSQLStrings = [
    '''
        CREATE TABLE IF NOT EXISTS $_tblName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          $_colUsername TEXT,
          $_colWeight DOUBLE,
          $_colHeight DOUBLE,
          $_colGender TEXT,
          $_colStatus TEXT,
          dateTime DATETIME
        )
        ''',
  ];

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tblName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tblName);
  }

  Future<int> update(String idColumn, Map<String, dynamic> row) async {
    Database db = await instance.database;
    dynamic id = row[idColumn];
    return await db.update(_tblName, row, where: '$idColumn =?', whereArgs: [id]);
  }

  Future<int> delete(String idColumn, dynamic idValue) async {
    Database db = await instance.database;
    return await db.delete(_tblName, where: '$idColumn =?', whereArgs: [idValue]);
  }
}

