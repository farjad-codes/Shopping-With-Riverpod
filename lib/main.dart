import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_with_riverpod/src/data/repos/auth_repo.dart' show AuthRepository;
import 'package:shopping_with_riverpod/src/data/repos/local_cart_repo.dart' show LocalCartRepository;
import 'package:shopping_with_riverpod/src/data/repos/remote_cart_repo.dart' show RemoteCartRepository;

import 'src/application/providers.dart';

void main() {
  runApp(
    // Wrap your app
    ProviderScope(
      overrides: [
        // Override the providers with real implementations
        authRepositoryProvider.overrideWithValue(AuthRepository()),
        localCartRepositoryProvider.overrideWithValue(LocalCartRepository()),
        remoteCartRepositoryProvider.overrideWithValue(RemoteCartRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Shopping with Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Shopping with Riverpod'),
        ),
      ),
    );
  }
}

