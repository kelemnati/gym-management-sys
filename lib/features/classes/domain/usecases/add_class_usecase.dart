import '../entities/gym_class.dart';
import '../repositories/class_repository.dart';

class AddClassUseCase {
  final ClassRepository repository;

  AddClassUseCase(this.repository);

  Future<void> call(GymClass gymClass) {
    return repository.addClass(gymClass);
  }
}
