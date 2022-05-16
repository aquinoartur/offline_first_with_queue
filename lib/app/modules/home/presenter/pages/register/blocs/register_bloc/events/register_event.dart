import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';

abstract class RegisterEvent {}

class AddAttendanceEvent extends RegisterEvent {
  final AttendanceEntity attendance;
  AddAttendanceEvent({required this.attendance});
}

class AddAttendanceListEvent extends RegisterEvent {
  final List<AttendanceEntity> attendances;
  AddAttendanceListEvent({required this.attendances});
}

class UpdateRemoteAttendancesEvent extends RegisterEvent {
  final List<AttendanceEntity> remoteAttendances;
  UpdateRemoteAttendancesEvent({
    required this.remoteAttendances,
  });
}

class UpdateLocalAttendancesEvent extends RegisterEvent {
  final List<AttendanceEntity> remoteAttendances;
  UpdateLocalAttendancesEvent({
    required this.remoteAttendances,
  });
}
