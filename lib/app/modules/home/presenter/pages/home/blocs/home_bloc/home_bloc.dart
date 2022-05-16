import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/domain/usecases/get_attendances_usecase.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/home_bloc/states/home_state.dart';
import 'package:offline_first/app/modules/home/presenter/pages/register/blocs/register_bloc/states/register_state.dart';

import '../../../register/blocs/register_bloc/events/register_event.dart';
import '../../../register/blocs/register_bloc/register_bloc.dart';
import 'events/home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAttendancesUsecase getAttendancesUsecase;
  final RegisterBloc registerBloc;

  HomeBloc({
    required this.getAttendancesUsecase,
    required this.registerBloc,
  }) : super(InitialHomeState()) {
    on<GetAttendanceListEvent>(_getAttendances);

    registerBloc.stream.listen((state) {
      if (state is LoadedRegisterState) {
        add(GetAttendanceListEvent());
      }
    });
  }

  Future<void> _getAttendances(
    GetAttendanceListEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.loadingHomeState());
    final result = await getAttendancesUsecase.getAttendances();

    result.fold(
      (error) => emit(state.errorHomeState(error.message)),
      (attendances) {
        emit(state.loadedHomeState(attendances));
        if (event.syncData) {
          registerBloc.add(
            UpdateRemoteAttendancesEvent(
              remoteAttendances: attendances,
            ),
          );
        }
      },
    );
  }
}
