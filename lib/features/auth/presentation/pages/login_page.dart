import 'package:checkin_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) return;

    setState(() => _loading = true);
    await ref
        .read(authNotifierProvider.notifier)
        .signIn(email: email, password: password);
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final errorMessage = authState is AuthError ? authState.message : null;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: const Key('email_field'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('password_field'),
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 24),
            if (errorMessage != null) ...[
              Text(
                errorMessage,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 16),
            ],
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    key: const Key('login_button'),
                    onPressed: _submit,
                    child: const Text('Entrar'),
                  ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.push(AppRoutes.register),
              child: const Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }
}
