class AttendanceEntity {
  final int? id;
  final bool isUrgency;
  final int number;
  final String title;
  final String description;
  final int cid;
  final DateTime createdTime;

  const AttendanceEntity({
    this.id,
    required this.isUrgency,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.cid,
  });

  AttendanceEntity copyWith({
    int? id,
    bool? isUrgency,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    int? cid,
  }) =>
      AttendanceEntity(
        id: id ?? this.id,
        isUrgency: isUrgency ?? this.isUrgency,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        cid: cid ?? this.cid,
      );
}
