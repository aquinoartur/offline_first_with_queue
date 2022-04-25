import '../domain/entity/attendance_entity.dart';
import '../presenter/models/attendance_db_model.dart';

class AttendanceMapper {
  static AttendanceEntity fromJson(Map<String, Object?> json) {
    return AttendanceEntity(
      id: json[AttendanceDbModel.id] as int?,
      isUrgency: json[AttendanceDbModel.isUrgency] == 1,
      number: json[AttendanceDbModel.number] as int,
      title: json[AttendanceDbModel.title] as String,
      description: json[AttendanceDbModel.description] as String,
      createdTime: DateTime.parse(json[AttendanceDbModel.time] as String),
      cid: json[AttendanceDbModel.cid] as int,
    );
  }

  Map<String, Object?> toJson(AttendanceEntity attendance) => {
        AttendanceDbModel.id: attendance.id,
        AttendanceDbModel.title: attendance.title,
        AttendanceDbModel.isUrgency: attendance.isUrgency ? 1 : 0,
        AttendanceDbModel.number: attendance.number,
        AttendanceDbModel.description: attendance.description,
        AttendanceDbModel.time: attendance.createdTime.toIso8601String(),
      };
}