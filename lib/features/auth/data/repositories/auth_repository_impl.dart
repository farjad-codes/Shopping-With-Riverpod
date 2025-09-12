import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource remote;
  final FlutterSecureStorage storage;

  AuthRepositoryImpl(this.remote, this.storage);

  @override
  Future<(String token, User user)> login(String email, String password) async {
    final response = await remote.login(email, password);
    await storage.write(key: 'token', value: response.token);
    return (response.token, response.user.toEntity());
  }

  @override
  Future<(String token, User user)> signup(String email, String password, String name) async {
    final response = await remote.signup(email, password, name);
    await storage.write(key: 'token', value: response.token);
    return (response.token, response.user.toEntity());
  }
}
