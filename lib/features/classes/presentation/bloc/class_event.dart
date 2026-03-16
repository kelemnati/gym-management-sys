import '../../domain/entities/gym_class.dart';

abstract class ClassEvent {}

class LoadClasses extends ClassEvent {}

class AddClassEvent extends ClassEvent {
  final GymClass gymClass;

  AddClassEvent(this.gymClass);
}
