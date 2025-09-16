import 'package:dio/dio.dart';
import '../models/auth_response_dto.dart';

class RemoteAuthDataSource {
  final Dio dio;
  RemoteAuthDataSource(this.dio);

  /// Expects the server response to be JSON like:
  /// { "token": "...", "user": { "id": "...", "email": "...", "name": "..." } }
  Future<AuthResponseDto> login(String email, String password) async {
    final response = await dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    final data = _normalizeResponse(response.data);
    return AuthResponseDto.fromJson(data);
  }

  Future<AuthResponseDto> signup(String name, String email, String password) async {
    final response = await dio.post('/auth/signup', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    final data = _normalizeResponse(response.data);
    return AuthResponseDto.fromJson(data);
  }

  // helper: ensure Map<String,dynamic>
  Map<String, dynamic> _normalizeResponse(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw Exception('Unexpected response payload: $data');
  }
}
