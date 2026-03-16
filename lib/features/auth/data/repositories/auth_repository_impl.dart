import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../../core/network/network_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<User> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      final userModel = await remoteDataSource.login(email, password);
      return userModel;
    } else {
      throw Exception('No internet connection');
    }
  }

  @override
  Future<void> logout() async {
    // Implement logout logic
  }
}
