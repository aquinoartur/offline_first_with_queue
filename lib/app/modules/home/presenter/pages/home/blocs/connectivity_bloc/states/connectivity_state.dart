abstract class ConnectivityState {
  const ConnectivityState();

  InitialConnectivityState initialAddState() => InitialConnectivityState();
  ConnectedState connectedState() => ConnectedState();
}

class InitialConnectivityState extends ConnectivityState {}

class ConnectedState extends ConnectivityState {}
