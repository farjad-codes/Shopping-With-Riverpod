import '../entities/user.dart';

abstract class AuthRepository {
  Future<(String token, User user)> login(String email, String password);
  Future<(String token, User user)> signup(String email, String password, String name);
}
