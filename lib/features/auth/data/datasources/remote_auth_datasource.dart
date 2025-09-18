import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../core/constants/api_constant.dart';
import '../models/auth_response_dto.dart';

class RemoteAuthDataSource {
  final Dio dio;
  RemoteAuthDataSource(this.dio);

  /// Expects the server response to be JSON like:
  /// { "token": "...", "user": { "id": "...", "email": "...", "name": "..." } }
  Future<AuthResponseDto> login(String email, String password) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}/auth/login',
        data: {'email': email, 'password': password},
        options: Options(validateStatus: (_) => true), // ✅ allow any status
      );
      if (response.statusCode == 200) {
        final data = _normalizeResponse(response.data);
        return AuthResponseDto.fromJson(data);
      } else {
        log('Login failed: ${response.statusCode} -> ${response.data}');
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      log('Error during login: $e');
      rethrow;
    }
  }

  Future<AuthResponseDto> signup(
    String name,
    String email,
    String password,
  ) async {
    try {
      log('Signup called in remote data source');
      final response = await dio.post(
        '${ApiConstants.baseUrl}/auth/register',
        data: {'name': name, 'email': email, 'password': password},
        options: Options(validateStatus: (_) => true), // ✅ allow any status
      );
      log('Response received: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Response received: ${response.data}');
        final data = _normalizeResponse(response.data);
        return AuthResponseDto.fromJson(data);
      } else {
        log('Signup failed: ${response.statusCode} -> ${response.data}');
        throw Exception(response.data['message'] ?? 'Signup failed');
      }
    } catch (e) {
      log('Error during signup: $e');
      rethrow;
    }
  }

  // helper: ensure Map<String,dynamic>
  Map<String, dynamic> _normalizeResponse(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw Exception('Unexpected response payload: $data');
  }
}
