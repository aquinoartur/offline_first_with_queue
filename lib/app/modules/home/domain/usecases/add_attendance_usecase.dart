import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';

import '../../../../shared/either/either.dart';
import '../failures/failures.dart';
import '../repository/attendances_repository.dart';

abstract class AddAttendanceUsecase {
  Future<Either<Failure, Unit>> addAttendance(
      {required List<AttendanceEntity> attendances, bool isRemoteUpdate = false});
}

class AddAttendanceUsecaseImpl implements AddAttendanceUsecase {
  final AttendancesRepository repository;

  AddAttendanceUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> addAttendance({
    required List<AttendanceEntity> attendances,
    bool isRemoteUpdate = false,
  }) async {
    return await repository.addAttendance(attendances: attendances, isRemoteUpdate: isRemoteUpdate);
  }
}
