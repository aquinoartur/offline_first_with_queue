abstract class ConnectivityState {
  const ConnectivityState();

  InitialConnectivityState initialAddState() => InitialConnectivityState();
  ConnectedState connectedState() => ConnectedState();
  DisconnectedState disconnectedState() => DisconnectedState();
}

class InitialConnectivityState extends ConnectivityState {}

class ConnectedState extends ConnectivityState {}
class DisconnectedState extends ConnectivityState {}
