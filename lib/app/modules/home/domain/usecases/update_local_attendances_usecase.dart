import '../../../../shared/either/either.dart';
import '../entity/attendance_entity.dart';
import '../failures/failures.dart';
import '../repository/attendances_repository.dart';

abstract class UpdateLocalAttendancesUsecase {
  Future<Either<Failure, Unit>> update({required List<AttendanceEntity> attendances});
}

class UpdateLocalAttendancesUsecaseImpl implements UpdateLocalAttendancesUsecase {
  final AttendancesRepository repository;

  UpdateLocalAttendancesUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> update({required List<AttendanceEntity> attendances}) async {
    return await repository.localUpdate(attendances);
  }
}
