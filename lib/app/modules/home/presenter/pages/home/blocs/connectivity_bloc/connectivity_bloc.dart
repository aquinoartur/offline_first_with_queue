import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/connectivity_bloc/events/connectivity_event.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/connectivity_bloc/states/connectivity_state.dart';
import 'package:offline_first/app/shared/connectivity/connectivity_service.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService connectivityService;

  ConnectivityBloc({
    required this.connectivityService,
  }) : super(InitialConnectivityState()) {
    on<ShowSyncDialogEvent>(_syncData);

    if (connectivityService.isOnline) {
      add(ShowSyncDialogEvent());
    }
  }

  Future<void> _syncData(
    ShowSyncDialogEvent event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(state.connectedState());
  }
}
