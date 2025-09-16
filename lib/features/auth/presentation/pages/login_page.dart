import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/auth_notifier.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: state.when(
          data: (user) => user != null
              ? Text('Welcome ${user.name}')
              : ElevatedButton(
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).login('test@mail.com', '123456');
                  },
                  child: const Text('Login'),
                ),
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Error: $e'),
        ),
      ),
    );
  }
}
