import '../../domain/entities/member.dart';

class MemberModel extends Member {
  MemberModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.membershipType});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      membershipType: json['membershipType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'membershipType': membershipType,
    };
  }
}
