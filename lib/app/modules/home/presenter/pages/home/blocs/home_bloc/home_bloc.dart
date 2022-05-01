import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/domain/usecases/get_attendances_usecase.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/home_bloc/states/home_state.dart';

import 'events/home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAttendancesUsecase getAttendancesUsecase;

  HomeBloc({
    required this.getAttendancesUsecase,
  }) : super(InitialHomeState()) {
    on<GetAttendanceListEvent>(_getAttendances);
  }

  Future<void> _getAttendances(
    GetAttendanceListEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.loadingHomeState());
    final result = await getAttendancesUsecase.getAttendances();

    result.fold(
      (error) => emit(state.errorHomeState(error.message)),
      (attendances) => emit(state.loadedHomeState(attendances)),
    );
  }
}
