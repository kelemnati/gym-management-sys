import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String email, String password) async {
    // Mock authentication for development
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Test credentials
    if (email == 'admin@gym.com' && password == 'admin123') {
      return UserModel(
        id: '1',
        name: 'Admin User',
        email: email,
      );
    } else if (email == 'staff@gym.com' && password == 'staff123') {
      return UserModel(
        id: '2',
        name: 'Staff User',
        email: email,
      );
    }

    // For production, uncomment the real API call:
    // final response = await dio.post('/login', data: {'email': email, 'password': password});
    // return UserModel.fromJson(response.data);

    throw Exception('Invalid email or password');
  }
}
