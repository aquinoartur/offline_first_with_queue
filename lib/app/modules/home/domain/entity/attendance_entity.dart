class AttendanceEntity {
  final int? id;
  final bool isUrgency;
  final String title;
  final String description;
  final int cid;
  final DateTime createdTime;

  const AttendanceEntity({
     this.id,
    required this.isUrgency,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.cid,
  });
}
