const String kTableName = 'attendance';

class AttendanceDbModel {
  static const String id = '_id';
  static const String isUrgency = 'isUrgency';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
  static const String cid = 'cid';

  static final List<String> values = [
    id,
    isUrgency,
    number,
    title,
    description,
    time,
    cid,
  ];
}
