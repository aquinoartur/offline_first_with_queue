import 'package:offline_first/app/modules/home/infra/models/attendance_db_model.dart';

import '../../domain/entity/attendance_entity.dart';

class AttendanceMapper {
  List<AttendanceEntity> fromMapList(List<Map<String, dynamic>> mapList) {
    return List<AttendanceEntity>.from(mapList.map((x) => fromMap(x)));
  }

  AttendanceEntity fromMap(Map<String, dynamic> map) {
    return AttendanceEntity(
      id: map[AttendanceDbModel.id] as int?,
      isUrgency: map[AttendanceDbModel.isUrgency] == 1,
      number: map[AttendanceDbModel.number] as int,
      title: map[AttendanceDbModel.title] as String,
      description: map[AttendanceDbModel.description] as String,
      createdTime: DateTime.parse(map[AttendanceDbModel.time] as String),
      cid: map[AttendanceDbModel.cid] as int,
    );
  }

  Map<String, dynamic> toMap(AttendanceEntity attendance) {
    return {
      AttendanceDbModel.id: attendance.id,
      AttendanceDbModel.title: attendance.title,
      AttendanceDbModel.isUrgency: attendance.isUrgency ? 1 : 0,
      AttendanceDbModel.number: attendance.number,
      AttendanceDbModel.description: attendance.description,
      AttendanceDbModel.time: attendance.createdTime.toIso8601String(),
    };
  }
}
