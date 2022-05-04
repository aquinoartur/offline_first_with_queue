import '../../../../../../domain/entity/attendance_entity.dart';

abstract class HomeState {
  List<AttendanceEntity>? attendances;
  HomeState({this.attendances});

  InitialHomeState initialAddState() => InitialHomeState();
  LoadingHomeState loadingHomeState() => LoadingHomeState();
  ErrorHomeState errorHomeState(String? error) => ErrorHomeState(error: error);
  LoadedHomeState loadedHomeState(List<AttendanceEntity> attendances) => LoadedHomeState(attendances: attendances);
}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  LoadedHomeState({required List<AttendanceEntity> attendances}) : super(attendances: attendances);
}

class ErrorHomeState extends HomeState {
  final String? error;
  ErrorHomeState({this.error});
}
