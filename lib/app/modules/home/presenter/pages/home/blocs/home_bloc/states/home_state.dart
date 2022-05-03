import '../../../../../../domain/entity/attendance_entity.dart';

abstract class HomeState {
  const HomeState();

  InitialHomeState initialAddState() => InitialHomeState();
  LoadingHomeState loadingHomeState() => LoadingHomeState();
  ErrorHomeState errorHomeState(String? error) => ErrorHomeState(error: error);
  LoadedHomeState loadedHomeState(List<AttendanceEntity> attendances) =>
      LoadedHomeState(attendances: attendances);
}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<AttendanceEntity> attendances;
  LoadedHomeState({required this.attendances});
}

class ErrorHomeState extends HomeState {
  final String? error;
  const ErrorHomeState({this.error});
}
