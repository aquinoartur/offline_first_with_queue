import 'package:firebase_storage/firebase_storage.dart';
import 'package:offline_first/app/modules/home/domain/repository/attendances_repository.dart';
import 'package:offline_first/app/modules/home/infra/datasources/attendances_local_datasource.dart';
import 'package:offline_first/app/modules/home/infra/datasources/attendances_remote_datasource.dart';
import 'package:offline_first/app/shared/either/either.dart';

import '../../../../shared/connectivity/connectivity_service.dart';
import '../../domain/entity/attendance_entity.dart';
import '../../domain/failures/failures.dart';

class AttendancesRepositoryImpl implements AttendancesRepository {
  final AttendancesRemoteDatasource remoteDatasource;
  final AttendancesLocalDatasource localDatasource;
  final ConnectivityService connectivityService;

  AttendancesRepositoryImpl(
    this.remoteDatasource,
    this.localDatasource,
    this.connectivityService,
  );

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendances() async {
    try {
      List<AttendanceEntity> result = [];

      if (connectivityService.isOnline) {
        result = await remoteDatasource.getAttendances();
      } else {
        result = await localDatasource.getAttendances();
      }

      return right(result);
    } on FirebaseException catch (e, s) {
      return left(DomainError(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, Unit>> addAttendance(List<AttendanceEntity> attendances) async {
    try {
      if (connectivityService.isOnline) {
        await remoteDatasource.addAttendances(attendances);
        //await localDatasource.addAttendances(attendances);
      } else {
        await localDatasource.addAttendances(attendances);
      }

      return right(unit);
    } on FirebaseException catch (e, s) {
      return left(DomainError(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceEntity>>> update() async {
    try {
      final result = await localDatasource.getAttendances();
      return right(result);
    } on FirebaseException catch (e, s) {
      return left(DomainError(message: e.message, stackTrace: s));
    }
  }
}
