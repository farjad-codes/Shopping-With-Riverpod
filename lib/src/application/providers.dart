import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_with_riverpod/src/data/repos/auth_repo.dart';
import 'package:shopping_with_riverpod/src/data/repos/local_cart_repo.dart';
import 'package:shopping_with_riverpod/src/data/repos/remote_cart_repo.dart';

// Global providers for repositories
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  throw UnimplementedError('authRepositoryProvider must be overridden');
});

final localCartRepositoryProvider = Provider<LocalCartRepository>((ref) {
  throw UnimplementedError('localCartRepositoryProvider must be overridden');
});

final remoteCartRepositoryProvider = Provider<RemoteCartRepository>((ref) {
  throw UnimplementedError('remoteCartRepositoryProvider must be overridden');
});
