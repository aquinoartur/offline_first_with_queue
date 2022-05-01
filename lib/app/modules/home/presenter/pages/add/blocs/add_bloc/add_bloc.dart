import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/domain/usecases/add_attendance_usecase.dart';
import 'package:offline_first/app/modules/home/presenter/pages/add/blocs/add_bloc/events/add_event.dart';
import 'package:offline_first/app/modules/home/presenter/pages/add/blocs/add_bloc/states/add_state.dart';

import '../../../../../../../shared/db/attendance_database.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final AddAttendanceUsecase addAttendanceUsecase;

  AddBloc({
    required this.addAttendanceUsecase,
  }) : super(InitialAddState()) {
    on<AddAttendanceEvent>(_addAttendance);
    on<AddAttendanceListEvent>(_addAttendanceList);
  }

  Future<void> _addAttendance(
    AddAttendanceEvent event,
    Emitter<AddState> emit,
  ) async {
    emit(state.loadingAddState());
    final result = await addAttendanceUsecase.addAttendance([event.attendance]);

    result.fold(
      (error) => emit(state.errorAddState(error.message)),
      (_) => emit(state.loadedAddState()),
    );
  }

  Future<void> _addAttendanceList(
    AddAttendanceListEvent event,
    Emitter<AddState> emit,
  ) async {
    emit(state.loadingAddState());
    final result = await addAttendanceUsecase.addAttendance(event.attendances);

    result.fold(
      (error) => emit(state.errorAddState(error.message)),
      (_) => emit(state.loadedAddState()),
    );
  }
}
