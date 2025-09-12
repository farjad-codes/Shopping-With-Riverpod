import 'package:dio/dio.dart';
import '../models/auth_response_dto.dart';

class RemoteAuthDataSource {
  final Dio _dio;

  RemoteAuthDataSource(this._dio);

  Future<AuthResponseDto> login(String email, String password) async {
    final res = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return AuthResponseDto.fromJson(res.data);
  }

  Future<AuthResponseDto> signup(String email, String password, String name) async {
    final res = await _dio.post('/auth/signup', data: {
      'email': email,
      'password': password,
      'name': name,
    });
    return AuthResponseDto.fromJson(res.data);
  }
}
