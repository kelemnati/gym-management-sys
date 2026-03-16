import 'package:dio/dio.dart';
import '../models/member_model.dart';

abstract class MemberRemoteDataSource {
  Future<List<MemberModel>> getMembers();
  Future<void> addMember(MemberModel member);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final Dio dio;

  MemberRemoteDataSourceImpl(this.dio);

  @override
  Future<List<MemberModel>> getMembers() async {
    // Mock data for production readiness
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return [
      MemberModel(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        membershipType: 'Premium',
      ),
      MemberModel(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        membershipType: 'Basic',
      ),
      MemberModel(
        id: '3',
        name: 'Mike Johnson',
        email: 'mike@example.com',
        membershipType: 'Premium',
      ),
      MemberModel(
        id: '4',
        name: 'Sarah Wilson',
        email: 'sarah@example.com',
        membershipType: 'Basic',
      ),
      MemberModel(
        id: '5',
        name: 'David Brown',
        email: 'david@example.com',
        membershipType: 'Premium',
      ),
    ];
  }

  @override
  Future<void> addMember(MemberModel member) async {
    // Mock add - in real app, this would call API
    await Future.delayed(const Duration(seconds: 1));
    // Simulate success
  }
}
