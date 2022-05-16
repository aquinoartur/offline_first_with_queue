import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/connectivity_bloc/events/connectivity_event.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/connectivity_bloc/states/connectivity_state.dart';
import 'package:offline_first/app/shared/connectivity/connectivity_service.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService connectivityService;

  ConnectivityBloc({
    required this.connectivityService,
  }) : super(InitialConnectivityState()) {
    on<ShowSyncRemoteDialogEvent>(_syncRemoteData);
    on<ShowSyncLocalDialogEvent>(_syncLocalData);

    connectivityService.addListener(() {
      if (connectivityService.isOnline) {
        add(ShowSyncRemoteDialogEvent());
      } else {
        add(ShowSyncLocalDialogEvent());
      }
    });
  }

  Future<void> _syncRemoteData(
    ShowSyncRemoteDialogEvent event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(state.connectedState());
  }

  Future<void> _syncLocalData (
    ShowSyncLocalDialogEvent event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(state.disconnectedState());
  }

  @override
  Future<void> close() {
    connectivityService.dispose();
    return super.close();
  }
}
