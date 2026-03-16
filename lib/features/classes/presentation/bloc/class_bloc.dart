import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_classes_usecase.dart';
import '../../domain/usecases/add_class_usecase.dart';
import 'class_event.dart';
import 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final GetClassesUseCase getClassesUseCase;
  final AddClassUseCase addClassUseCase;

  ClassBloc(this.getClassesUseCase, this.addClassUseCase)
      : super(ClassInitial()) {
    on<LoadClasses>((event, emit) async {
      emit(ClassLoading());
      try {
        final classes = await getClassesUseCase();
        emit(ClassLoaded(classes));
      } catch (e) {
        emit(ClassError(e.toString()));
      }
    });
    on<AddClassEvent>((event, emit) async {
      emit(ClassLoading());
      try {
        await addClassUseCase(event.gymClass);
        final classes = await getClassesUseCase();
        emit(ClassLoaded(classes));
      } catch (e) {
        emit(ClassError(e.toString()));
      }
    });
  }
}
