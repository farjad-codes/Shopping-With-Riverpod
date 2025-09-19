import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../headers.dart';
import '../../application/providers/auth_notifier.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameCtl.text.trim();
      final email = _emailCtl.text.trim();
      final pass = _passCtl.text.trim();
      ref.read(authNotifierProvider.notifier).signup(name, email, pass);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: authState.when(
          data: (user) {
            if (user != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.goNamed(AppRouteNames.home);
              });
            }

            if (user != null) {
              return Center(child: Text('Signed up as ${user.name}'));
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtl,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: Validators.validateName,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailCtl,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passCtl,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      context.goNamed(AppRouteNames.login);
                    },
                    child: const Text('Already have an account? Log in'),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Column(
            children: [
              Text('Error: $e', style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).state =
                      const AsyncValue.data(null);
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
