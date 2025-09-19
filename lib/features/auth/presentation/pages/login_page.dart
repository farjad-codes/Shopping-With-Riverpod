import '../../../../headers.dart';
import '../../application/providers/auth_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final success = await ref
          .read(authNotifierProvider.notifier)
          .login(email, password);
      if (!mounted) return; // ✅ check if still in tree
      if (!success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
      }
      if (success) {
        context.goNamed(AppRouteNames.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: Validators.validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              state.when(
                data: (user) {
                  if (user != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.goNamed(AppRouteNames.home);
                    });
                  }

                  return user != null
                      ? Text('Welcome ${user.name}')
                      : ElevatedButton(
                          onPressed: _submit,
                          child: const Text('Login'),
                        );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  context.goNamed(AppRouteNames.signup);
                },
                child: const Text('Create New Account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
