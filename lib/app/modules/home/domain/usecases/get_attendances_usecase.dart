import 'package:offline_first/app/modules/home/domain/failures/failures.dart';
import 'package:offline_first/app/shared/either/either.dart';

import '../entity/attendance_entity.dart';
import '../repository/attendances_repository.dart';

abstract class GetAttendancesUsecase {
  Future<Either<Failure, List<AttendanceEntity>>> getAttendances();
}

class GetAttendancesUsecaseImpl implements GetAttendancesUsecase {
  final AttendancesRepository repository;

  GetAttendancesUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendances() async {
    return await repository.getAttendances();
  }
}
