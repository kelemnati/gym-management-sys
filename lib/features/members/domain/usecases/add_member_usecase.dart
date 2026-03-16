import '../entities/member.dart';
import '../repositories/member_repository.dart';

class AddMemberUseCase {
  final MemberRepository repository;

  AddMemberUseCase(this.repository);

  Future<void> call(Member member) {
    return repository.addMember(member);
  }
}
