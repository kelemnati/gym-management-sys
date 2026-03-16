import '../entities/member.dart';
import '../repositories/member_repository.dart';

class GetMembersUseCase {
  final MemberRepository repository;

  GetMembersUseCase(this.repository);

  Future<List<Member>> call() {
    return repository.getMembers();
  }
}
