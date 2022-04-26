import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';

abstract class AddEvent {}

class AddAttendanceEvent extends AddEvent {
  final AttendanceEntity attendance;
  AddAttendanceEvent({required this.attendance});
}

class AddAttendanceListEvent extends AddEvent {
  final List<AttendanceEntity> attendances;
  AddAttendanceListEvent({required this.attendances});
}
