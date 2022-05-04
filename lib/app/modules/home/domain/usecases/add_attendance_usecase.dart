import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';

import '../../../../shared/either/either.dart';
import '../failures/failures.dart';
import '../repository/attendances_repository.dart';

abstract class AddAttendanceUsecase {
  Future<Either<Failure, Unit>> addAttendance(List<AttendanceEntity> attendances);
}

class AddAttendanceUsecaseImpl implements AddAttendanceUsecase {
  final AttendancesRepository repository;

  AddAttendanceUsecaseImpl(this.repository);

  @override
  Future<Either<Failure, Unit>> addAttendance(List<AttendanceEntity> attendances) async {

    var list = attendances.where((attendance) => attendance.createdTime.day == DateTime.now().day).toList();
    return await repository.addAttendance(list);
  }
}
