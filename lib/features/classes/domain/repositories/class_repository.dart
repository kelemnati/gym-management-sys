import '../entities/gym_class.dart';

abstract class ClassRepository {
  Future<List<GymClass>> getClasses();
  Future<void> addClass(GymClass gymClass);
}
