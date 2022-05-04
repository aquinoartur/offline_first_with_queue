import '../../../../shared/either/either.dart';
import '../entity/attendance_entity.dart';
import '../failures/failures.dart';

abstract class AttendancesRepository {
  Future<Either<Failure, List<AttendanceEntity>>> getAttendances();
  Future<Either<Failure, Unit>> addAttendance(List<AttendanceEntity> attendances);
  Future<Either<Failure, List<AttendanceEntity>>> update();
}
