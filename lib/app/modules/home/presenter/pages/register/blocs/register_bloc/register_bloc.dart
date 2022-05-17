import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entity/attendance_entity.dart';
import '../../../../../domain/usecases/add_attendance_usecase.dart';
import 'states/register_state.dart';

import '../../../../../domain/usecases/update_remote_attendances_usecase.dart';
import 'events/register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AddAttendanceUsecase addAttendanceUsecase;
  final UpdateRemoteAttendancesUsecase updateRemoteAttendanceUsecase;

  RegisterBloc({
    required this.addAttendanceUsecase,
    required this.updateRemoteAttendanceUsecase,
  }) : super(InitialRegisterState()) {
    on<AddAttendanceEvent>(_addAttendance);
    on<AddAttendanceListEvent>(_addAttendanceList);
    on<RegisterUpdateRemoteAttendancesEvent>(_updateRemoteAttendances);
  }

  Future<void> _addAttendance(
    AddAttendanceEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.loadingRegisterState());
    final result = await addAttendanceUsecase.addAttendance(attendances: [event.attendance]);

    result.fold(
      (error) => emit(state.errorRegisterState(error.message)),
      (_) => emit(state.loadedRegisterState()),
    );
  }

  Future<void> _addAttendanceList(
    AddAttendanceListEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.loadingRegisterState());
    final result = await addAttendanceUsecase.addAttendance(attendances: event.attendances);

    result.fold(
      (error) => emit(state.errorRegisterState(error.message)),
      (_) => emit(state.loadedRegisterState()),
    );
  }

  Future<void> _updateRemoteAttendances(
    RegisterUpdateRemoteAttendancesEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.loadingRegisterState());
    List<AttendanceEntity> list = [];
    final result = await updateRemoteAttendanceUsecase.getAttendancesForRemoteUpdate();

    result.fold(
      (error) => emit(state.errorRegisterState(error.message)),
      (localAttendances) async {
        list = localAttendances.where((localItem) {
          bool value = true;
          for (var remoteItem in event.remoteAttendances) {
            if (localItem.id == remoteItem.id) value = false;
          }
          return value;
        }).toList();
      },
    );

    if (list.isNotEmpty) {
      final resultUpdate = await addAttendanceUsecase.addAttendance(attendances: list, isRemoteUpdate: true);
      resultUpdate.fold(
        (error) => emit(state.errorRegisterState(error.message)),
        (_) => emit(state.loadedRegisterState()),
      );
    } else {
      emit(state.loadedRegisterState());
    }
  }
}
