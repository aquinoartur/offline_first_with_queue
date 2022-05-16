import '../../domain/entity/attendance_entity.dart';

abstract class AttendancesLocalDatasource {
  Future<List<AttendanceEntity>> getAttendances();
  Future<List<AttendanceEntity>> addAttendances(List<AttendanceEntity> attendances);
  Future<void> update(List<AttendanceEntity> attendances);
}
