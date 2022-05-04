import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';

import '../../../../shared/either/either.dart';
import '../failures/failures.dart';
import '../repository/attendances_repository.dart';

abstract class UpdateAttendanceUsecase {
  Future<Either<Failure, List<AttendanceEntity>>> update();
}

class UpdateAttendanceUsecaseImpl implements UpdateAttendanceUsecase {
  final AttendancesRepository repository;

  UpdateAttendanceUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, List<AttendanceEntity>>> update() async {
    return await repository.update();
  }
}
