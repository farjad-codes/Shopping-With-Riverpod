import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login(String email, String password) async {
    final dto = await remote.login(email, password);
    return dto.user.toDomain();
  }

  @override
  Future<User> signup(String name, String email, String password) async {
    final dto = await remote.signup(name, email, password);
    return dto.user.toDomain();
  }
}
