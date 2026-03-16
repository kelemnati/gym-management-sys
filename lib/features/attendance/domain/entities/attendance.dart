class Attendance {
  final String id;
  final String memberId;
  final String classId;
  final DateTime date;
  final String status; // present, absent

  Attendance({
    required this.id,
    required this.memberId,
    required this.classId,
    required this.date,
    required this.status,
  });
}
