import '../../../../shared/either/either.dart';
import '../entity/attendance_entity.dart';
import '../failures/failures.dart';

abstract class AttendancesRepository {
  Future<Either<Failure, List<AttendanceEntity>>> getAttendances();
  Future<Either<Failure, Unit>> addAttendance(
      {required List<AttendanceEntity> attendances, bool isRemoteUpdate = false});
  Future<Either<Failure, List<AttendanceEntity>>> getAttendancesForRemoteUpdate();
  Future<Either<Failure, Unit>> localUpdate(List<AttendanceEntity> attendances);
}
