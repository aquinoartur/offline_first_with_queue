import '../../domain/entity/attendance_entity.dart';

abstract class AttendancesRemoteDatasource {
  Future<List<AttendanceEntity>> getAttendances();
  Future<void> addAttendances(List<AttendanceEntity> attendances);
}
