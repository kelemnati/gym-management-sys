import '../../domain/entities/gym_class.dart';

abstract class ClassState {}

class ClassInitial extends ClassState {}

class ClassLoading extends ClassState {}

class ClassLoaded extends ClassState {
  final List<GymClass> classes;

  ClassLoaded(this.classes);
}

class ClassError extends ClassState {
  final String message;

  ClassError(this.message);
}
