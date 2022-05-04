import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/domain/usecases/add_attendance_usecase.dart';
import 'package:offline_first/app/modules/home/presenter/pages/add/blocs/add_bloc/events/add_event.dart';
import 'package:offline_first/app/modules/home/presenter/pages/add/blocs/add_bloc/states/add_state.dart';

import '../../../../../domain/usecases/update_attendance_usecase.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final AddAttendanceUsecase addAttendanceUsecase;
  final UpdateAttendanceUsecaseImpl updateAttendanceUsecase;

  AddBloc({
    required this.addAttendanceUsecase,
    required this.updateAttendanceUsecase,
  }) : super(InitialAddState()) {
    on<AddAttendanceEvent>(_addAttendance);
    on<AddAttendanceListEvent>(_addAttendanceList);
    on<UpdateAttendanceEvent>(_updateAttendances);
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

  Future<void> _updateAttendances(
    UpdateAttendanceEvent event,
    Emitter<AddState> emit,
  ) async {
    emit(state.loadingAddState());
    final result = await updateAttendanceUsecase.update();

    result.fold(
      (error) => emit(state.errorAddState(error.message)),
      (localAttendances) {
        var list = localAttendances.where((localItem) {
          bool value = true;
          for (var remoteItem in event.remoteAttendances) {
            if (localItem.id == remoteItem.id) value = false;
          }
          return value;
        }).toList();
        add(AddAttendanceListEvent(attendances: list));
      },
    );
  }
}
