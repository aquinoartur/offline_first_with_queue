import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/usecases/add_attendance_usecase.dart';
import '../../../../../domain/usecases/update_local_attendances_usecase.dart';
import 'states/register_state.dart';

import '../../../../../domain/usecases/update_remote_attendances_usecase.dart';
import 'events/register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AddAttendanceUsecase addAttendanceUsecase;
  final UpdateRemoteAttendancesUsecaseImpl updateRemoteAttendanceUsecase;
  final UpdateLocalAttendancesUsecase updateLocalAttendanceUsecase;

  RegisterBloc({
    required this.addAttendanceUsecase,
    required this.updateRemoteAttendanceUsecase,
    required this.updateLocalAttendanceUsecase,
  }) : super(InitialRegisterState()) {
    on<AddAttendanceEvent>(_addAttendance);
    on<AddAttendanceListEvent>(_addAttendanceList);
    on<UpdateRemoteAttendancesEvent>(_updateRemoteAttendances);
    on<UpdateLocalAttendancesEvent>(_updateLocalAttendances);
  }

  Future<void> _addAttendance(
    AddAttendanceEvent event,
    Emitter<RegisterState> emit,
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
    Emitter<RegisterState> emit,
  ) async {
    emit(state.loadingAddState());
    final result = await addAttendanceUsecase.addAttendance(event.attendances);

    result.fold(
      (error) => emit(state.errorAddState(error.message)),
      (_) => emit(state.loadedAddState()),
    );
  }

  Future<void> _updateRemoteAttendances(
    UpdateRemoteAttendancesEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.loadingAddState());
    final result = await updateRemoteAttendanceUsecase.update();

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

  Future<void> _updateLocalAttendances(
    UpdateLocalAttendancesEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.loadingAddState());
    await updateLocalAttendanceUsecase.update(attendances: event.remoteAttendances);
  }
}
