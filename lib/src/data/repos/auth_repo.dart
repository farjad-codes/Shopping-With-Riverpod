import '../../domain/models/app_user_model.dart' show AppUser;

abstract class AuthRepository {
  /// returns null if the user is not signed in
  AppUser? get currentUser;

  /// useful to watch auth state changes in realtime
  Stream<AppUser?> authStateChanges();

  // other sign in methods
}

class FakeAuthRepository implements AuthRepository {
  AppUser? _user;

  @override
  AppUser? get currentUser => _user;

  @override
  Stream<AppUser?> authStateChanges() async* {
    // Simulate a user signing in after 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    _user = AppUser(uid: '1', email: 'test@example.com', displayName: 'Test User');
    yield _user;
  }

  // other sign in methods
}
