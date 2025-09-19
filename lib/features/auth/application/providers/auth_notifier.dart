import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../headers.dart';
import '../../data/datasources/remote_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/entities/user.dart';

/// --- AuthNotifier ---
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthNotifier({required this.loginUseCase, required this.signupUseCase})
    : super(const AsyncValue.data(null));

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await loginUseCase(email, password);
      state = AsyncValue.data(user);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await signupUseCase(name, email, password);
      state = AsyncValue.data(user);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  void setEmail(String value) {}

  void logout() {
    state = const AsyncValue.data(null);
  }
}

/// --- Provider wiring ---
final dioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  return dio;
});

final remoteAuthDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return RemoteAuthDataSource(dio);
});

final authRepositoryProvider = Provider((ref) {
  final remote = ref.watch(remoteAuthDataSourceProvider);
  return AuthRepositoryImpl(remote);
});

final loginUseCaseProvider = Provider((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return LoginUseCase(repo);
});

final signupUseCaseProvider = Provider((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return SignupUseCase(repo);
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
      final loginUseCase = ref.watch(loginUseCaseProvider);
      final signupUseCase = ref.watch(signupUseCaseProvider);
      return AuthNotifier(
        loginUseCase: loginUseCase,
        signupUseCase: signupUseCase,
      );
    });
