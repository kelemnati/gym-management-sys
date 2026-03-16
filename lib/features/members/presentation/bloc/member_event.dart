import '../../domain/entities/member.dart';

abstract class MemberEvent {}

class LoadMembers extends MemberEvent {}

class AddMemberEvent extends MemberEvent {
  final Member member;

  AddMemberEvent(this.member);
}
