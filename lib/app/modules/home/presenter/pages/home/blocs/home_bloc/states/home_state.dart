import '../../../../../../domain/entity/attendance_entity.dart';

abstract class HomeState {
  final List<AttendanceEntity>? attendances;
  final List<AttendanceEntity>? todayAttendances;

  HomeState({this.attendances, this.todayAttendances});

  InitialHomeState initialAddState() => InitialHomeState();
  LoadingHomeState loadingHomeState() => LoadingHomeState();
  ErrorHomeState errorHomeState(String? error) => ErrorHomeState(error: error);
  LoadedHomeState loadedHomeState({
    required List<AttendanceEntity> attendances,
    required List<AttendanceEntity> todayAttendances,
  }) {
    return LoadedHomeState(
      attendances: attendances,
      todayAttendances: todayAttendances,
    );
  }
}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  LoadedHomeState({
    required List<AttendanceEntity> attendances,
    required List<AttendanceEntity> todayAttendances,
  }) : super(attendances: todayAttendances, todayAttendances: todayAttendances);
}

class ErrorHomeState extends HomeState {
  final String? error;
  ErrorHomeState({this.error});
}
