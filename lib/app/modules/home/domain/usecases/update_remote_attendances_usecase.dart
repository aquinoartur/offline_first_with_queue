import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';

import '../../../../shared/either/either.dart';
import '../failures/failures.dart';
import '../repository/attendances_repository.dart';

abstract class UpdateRemoteAttendancesUsecase {
  Future<Either<Failure, List<AttendanceEntity>>> getAttendancesForRemoteUpdate();
}

class UpdateRemoteAttendancesUsecaseImpl implements UpdateRemoteAttendancesUsecase {
  final AttendancesRepository repository;

  UpdateRemoteAttendancesUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendancesForRemoteUpdate() async {
    return await repository.getAttendancesForRemoteUpdate();
  }
}
