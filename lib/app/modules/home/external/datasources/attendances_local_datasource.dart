import 'package:flutter/cupertino.dart';
import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';
import 'package:offline_first/app/modules/home/domain/failures/failures.dart';
import 'package:offline_first/app/shared/db/attendance_database.dart';

import '../../infra/datasources/attendances_local_datasource.dart';

class AttendancesLocalDatasourceImpl implements AttendancesLocalDatasource {
  final AttendanceDatabase database;

  AttendancesLocalDatasourceImpl(this.database);

  @override
  Future<List<AttendanceEntity>> getAttendances() async {
    try {
      return await database.readAll();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<AttendanceEntity>> addAttendances(List<AttendanceEntity> attendances) async {
    try {
      List<AttendanceEntity> result = [];
      for (var attendance in attendances) {
        final entity = await database.create(attendance);
        result.add(entity);
      }
      return result;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> update(List<AttendanceEntity> attendances) async {
    try {
      for (var attendance in attendances) {
        final id = await database.update(attendance);
        debugPrint(id.toString());
      }
    } catch (e, s) {
      throw DatasourceError(stackTrace: s);
    }
  }
}
