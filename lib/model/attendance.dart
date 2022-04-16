import 'attendance_db_fields.dart';

class Attendance {
  final int? id;
  final bool isUrgency;
  final int number;
  final String title;
  final String description;
  final int cid;
  final DateTime createdTime;

  const Attendance({
    this.id,
    required this.isUrgency,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.cid,
  });

  Attendance copyWith({
    int? id,
    bool? isUrgency,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    int? cid,
  }) =>
      Attendance(
        id: id ?? this.id,
        isUrgency: isUrgency ?? this.isUrgency,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        cid: cid ?? this.cid,
      );

  static Attendance fromJson(Map<String, Object?> json) => Attendance(
        id: json[AttendanceDbFields.id] as int?,
        isUrgency: json[AttendanceDbFields.isUrgency] == 1,
        number: json[AttendanceDbFields.number] as int,
        title: json[AttendanceDbFields.title] as String,
        description: json[AttendanceDbFields.description] as String,
        createdTime: DateTime.parse(json[AttendanceDbFields.time] as String),
        cid: json[AttendanceDbFields.cid] as int,
      );

  Map<String, Object?> toJson() => {
        AttendanceDbFields.id: id,
        AttendanceDbFields.title: title,
        AttendanceDbFields.isUrgency: isUrgency ? 1 : 0,
        AttendanceDbFields.number: number,
        AttendanceDbFields.description: description,
        AttendanceDbFields.time: createdTime.toIso8601String(),
      };
}
