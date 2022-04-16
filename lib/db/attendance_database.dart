import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/attendance.dart';
import '../model/attendance_db_fields.dart';

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
CREATE TABLE $tableAttendances ( 
  ${AttendanceDbFields.id} $idType, 
  ${AttendanceDbFields.isUrgency} $boolType,
  ${AttendanceDbFields.number} $integerType,
  ${AttendanceDbFields.title} $textType,
  ${AttendanceDbFields.description} $textType,
  ${AttendanceDbFields.time} $textType,
  ${AttendanceDbFields.cid} $integerType
  )
''');
  }

  Future<Attendance> create(Attendance note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableAttendances, note.toJson());
    return note.copyWith(id: id);
  }

  Future<Attendance> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAttendances,
      columns: AttendanceDbFields.values,
      where: '${AttendanceDbFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Attendance.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Attendance>> readAll() async {
    final db = await instance.database;

    const orderBy = '${AttendanceDbFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableAttendances, orderBy: orderBy);

    return result.map((json) => Attendance.fromJson(json)).toList();
  }

  Future<int> update(Attendance note) async {
    final db = await instance.database;

    return db.update(
      tableAttendances,
      note.toJson(),
      where: '${AttendanceDbFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableAttendances,
      where: '${AttendanceDbFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
