import '../../../../../../domain/entity/attendance_entity.dart';

abstract class AddState {
  const AddState();

  InitialAddState initialAddState() => InitialAddState();
  LoadingAddState loadingAddState() => LoadingAddState();
  ErrorAddState errorAddState(String? error) => ErrorAddState(error: error);
  LoadedAddState loadedAddState() => LoadedAddState();
  UpdatedAddState updatedAddState({required List<AttendanceEntity> attendances}) =>
      UpdatedAddState(attendances: attendances);
}

class InitialAddState extends AddState {}

class LoadingAddState extends AddState {}

class LoadedAddState extends AddState {}

class UpdatedAddState extends AddState {
  final List<AttendanceEntity> attendances;
  UpdatedAddState({required this.attendances});
}

class ErrorAddState extends AddState {
  final String? error;
  const ErrorAddState({this.error});
}
