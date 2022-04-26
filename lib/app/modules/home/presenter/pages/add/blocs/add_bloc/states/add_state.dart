abstract class AddState {
  const AddState();

  InitialAddState initialAddState() => InitialAddState();
  LoadingAddState loadingAddState() => LoadingAddState();
  ErrorAddState errorAddState(String? error) => ErrorAddState(error: error);
  LoadedAddState loadedAddState() => LoadedAddState();
}

class InitialAddState extends AddState {}
class LoadingAddState extends AddState {}
class LoadedAddState extends AddState {}

class ErrorAddState extends AddState {
  final String? error;
  const ErrorAddState({this.error});
}
