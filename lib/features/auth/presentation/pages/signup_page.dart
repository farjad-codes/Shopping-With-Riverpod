import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/auth_notifier.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _nameCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();

  @override
  void dispose() {
    _nameCtl.dispose();
    _emailCtl.dispose();
    _passCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: authState.when(
          data: (user) {
            if (user != null) {
              return Column(
                children: [
                  Text('Signed up as ${user.name}'),
                ],
              );
            }

            return Column(
              children: [
                TextField(controller: _nameCtl, decoration: const InputDecoration(labelText: 'Name')),
                const SizedBox(height: 8),
                TextField(controller: _emailCtl, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 8),
                TextField(controller: _passCtl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final name = _nameCtl.text.trim();
                    final email = _emailCtl.text.trim();
                    final pass = _passCtl.text.trim();
                    ref.read(authNotifierProvider.notifier).signup(name, email, pass);
                  },
                  child: const Text('Sign up'),
                )
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Column(
            children: [
              Text('Error: $e'),
              ElevatedButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).state = const AsyncValue.data(null);
                },
                child: const Text('Reset'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
