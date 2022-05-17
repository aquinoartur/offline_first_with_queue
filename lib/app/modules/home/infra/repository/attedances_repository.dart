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
        await localUpdate(result);
      } else {
        result = await localDatasource.getAttendances();
      }

      return right(result);
    } on FirebaseException catch (e, s) {
      return left(DatasourceError(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, Unit>> addAttendance({
    required List<AttendanceEntity> attendances,
    bool isRemoteUpdate = false,
  }) async {
    try {
      if (connectivityService.isOnline) {
        if (isRemoteUpdate) {
          await remoteDatasource.addAttendances(attendances);
        } else {
          final attendancesUpdated = await localDatasource.addAttendances(attendances);

          await remoteDatasource.addAttendances(attendancesUpdated);
        }
      } else {
        await localDatasource.addAttendances(attendances);
      }

      return right(unit);
    } on FirebaseException catch (e, s) {
      return left(DatasourceError(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<AttendanceEntity>>> getAttendancesForRemoteUpdate() async {
    try {
      List<AttendanceEntity> result = [];

      result = await localDatasource.getAttendances();

      return right(result);
    } on FirebaseException catch (e, s) {
      return left(DatasourceError(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, Unit>> localUpdate(List<AttendanceEntity> attendances) async {
    try {
      await localDatasource.update(attendances);
      return right(unit);
    } on Failure catch (_, s) {
      return left(DatabasesourceError(message: 'Database error', stackTrace: s));
    }
  }
}
