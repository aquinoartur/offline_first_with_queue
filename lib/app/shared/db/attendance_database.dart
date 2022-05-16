import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/home/domain/entity/attendance_entity.dart';
import '../../modules/home/external/mappers/attendance_mapper.dart';
import '../../modules/home/infra/models/attendance_db_model.dart';

class AttendanceDatabase {
  static final AttendanceDatabase instance = AttendanceDatabase._init();

  static Database? _database;

  AttendanceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('attendance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $kTableName ( 
  ${AttendanceDbModel.id} $idType, 
  ${AttendanceDbModel.isUrgency} $boolType,
  ${AttendanceDbModel.title} $textType,
  ${AttendanceDbModel.description} $textType,
  ${AttendanceDbModel.time} $textType,
  ${AttendanceDbModel.cid} $integerType
  )
''');
  }

  Future<AttendanceEntity> create(AttendanceEntity attendance) async {
    final db = await instance.database;

    final id = await db.insert(
      kTableName,
      AttendanceMapper().toMap(attendance),
    );

    return AttendanceEntity(
      id: id,
      cid: attendance.cid,
      description: attendance.description,
      createdTime: attendance.createdTime,
      isUrgency: attendance.isUrgency,
      title: attendance.title,
    );
  }

  Future<AttendanceEntity> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      kTableName,
      columns: AttendanceDbModel.values,
      where: '${AttendanceDbModel.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AttendanceMapper().fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<AttendanceEntity>> readAll() async {
    final db = await instance.database;

    const orderBy = '${AttendanceDbModel.time} ASC';

    final result = await db.query(kTableName, orderBy: orderBy);

    return result.map((json) => AttendanceMapper().fromMap(json)).toList();
  }

  Future<int> update(AttendanceEntity attendance) async {
    final db = await instance.database;

    var attendanceMap = AttendanceMapper().toMap(attendance);

    return db.update(
      kTableName,
      attendanceMap,
      where: '${AttendanceDbModel.id} = ?',
      whereArgs: [attendance.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      kTableName,
      where: '${AttendanceDbModel.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
