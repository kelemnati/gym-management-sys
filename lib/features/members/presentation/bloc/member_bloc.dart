import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_members_usecase.dart';
import '../../domain/usecases/add_member_usecase.dart';
import 'member_event.dart';
import 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final GetMembersUseCase getMembersUseCase;
  final AddMemberUseCase addMemberUseCase;

  MemberBloc(this.getMembersUseCase, this.addMemberUseCase)
      : super(MemberInitial()) {
    on<LoadMembers>((event, emit) async {
      emit(MemberLoading());
      try {
        final members = await getMembersUseCase();
        emit(MemberLoaded(members));
      } catch (e) {
        emit(MemberError(e.toString()));
      }
    });
    on<AddMemberEvent>((event, emit) async {
      emit(MemberLoading());
      try {
        await addMemberUseCase(event.member);
        final members = await getMembersUseCase();
        emit(MemberLoaded(members));
      } catch (e) {
        emit(MemberError(e.toString()));
      }
    });
  }
}
