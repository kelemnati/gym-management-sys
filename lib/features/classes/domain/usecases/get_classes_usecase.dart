import '../entities/gym_class.dart';
import '../repositories/class_repository.dart';

class GetClassesUseCase {
  final ClassRepository repository;

  GetClassesUseCase(this.repository);

  Future<List<GymClass>> call() {
    return repository.getClasses();
  }
}
