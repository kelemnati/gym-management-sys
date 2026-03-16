import '../../domain/entities/member.dart';
import '../../domain/repositories/member_repository.dart';
import '../datasources/member_remote_data_source.dart';
import '../models/member_model.dart';
import '../../../../core/network/network_info.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MemberRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<List<Member>> getMembers() async {
    if (await networkInfo.isConnected) {
      final members = await remoteDataSource.getMembers();
      return members;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> addMember(Member member) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.addMember(MemberModel(
        id: member.id,
        name: member.name,
        email: member.email,
        membershipType: member.membershipType,
      ));
    } else {
      throw Exception('No internet connection');
    }
  }
}
