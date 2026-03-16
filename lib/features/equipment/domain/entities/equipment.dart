class Equipment {
  final String id;
  final String name;
  final String type;
  final String status; // available, in_use, maintenance

  Equipment({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
  });
}
