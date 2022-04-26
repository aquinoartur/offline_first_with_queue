import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';
import 'package:offline_first/app/shared/db/attendance_database.dart';

import '../../infra/datasources/attendances_local_datasource.dart';

class AttendancesLocalDatasourceImpl implements AttendancesLocalDatasource {
  final AttendanceDatabase database;

  AttendancesLocalDatasourceImpl(this.database);

  @override
  Future<List<AttendanceEntity>> getAttendances() async {
    var path = 'attendances';
    try {
      return [];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> addAttendances(List<AttendanceEntity> attendances) async {
    var path = 'attendances';
    try {} catch (_) {
      rethrow;
    }
  }
}
