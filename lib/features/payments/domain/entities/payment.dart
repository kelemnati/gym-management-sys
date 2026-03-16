class Payment {
  final String id;
  final String memberId;
  final double amount;
  final DateTime date;
  final String status; // paid, pending, overdue

  Payment({
    required this.id,
    required this.memberId,
    required this.amount,
    required this.date,
    required this.status,
  });
}
