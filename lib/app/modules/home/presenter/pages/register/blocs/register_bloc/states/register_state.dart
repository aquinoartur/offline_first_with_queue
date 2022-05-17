abstract class RegisterState {
  const RegisterState();

  InitialRegisterState initialRegisterState() => InitialRegisterState();
  LoadingRegisterState loadingRegisterState() => LoadingRegisterState();
  ErrorRegisterState errorRegisterState(String? error) => ErrorRegisterState(error: error);
  LoadedRegisterState loadedRegisterState() => LoadedRegisterState();
}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class LoadedRegisterState extends RegisterState {}

class ErrorRegisterState extends RegisterState {
  final String? error;
  const ErrorRegisterState({this.error});
}
