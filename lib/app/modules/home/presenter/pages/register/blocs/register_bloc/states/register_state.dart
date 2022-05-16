import '../../../../../../domain/entity/attendance_entity.dart';

abstract class RegisterState {
  const RegisterState();

  InitialRegisterState initialRegisterState() => InitialRegisterState();
  LoadingRegisterState loadingAddState() => LoadingRegisterState();
  ErrorRegisterState errorAddState(String? error) => ErrorRegisterState(error: error);
  LoadedRegisterState loadedAddState() => LoadedRegisterState();
  UpdatedRegisterState updatedAddState({required List<AttendanceEntity> attendances}) =>
      UpdatedRegisterState(attendances: attendances);
}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class LoadedRegisterState extends RegisterState {}

class UpdatedRegisterState extends RegisterState {
  final List<AttendanceEntity> attendances;
  UpdatedRegisterState({required this.attendances});
}

class ErrorRegisterState extends RegisterState {
  final String? error;
  const ErrorRegisterState({this.error});
}
