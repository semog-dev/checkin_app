import 'package:checkin_app/features/group/presentation/providers/group_provider.dart';
import 'package:core/core.dart' show AppRoutes;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JoinGroupPage extends ConsumerStatefulWidget {
  const JoinGroupPage({super.key});

  @override
  ConsumerState<JoinGroupPage> createState() => _JoinGroupPageState();
}

class _JoinGroupPageState extends ConsumerState<JoinGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final group = await ref
        .read(groupsNotifierProvider.notifier)
        .joinGroup(_codeController.text.trim());

    if (!mounted) return;
    setState(() => _loading = false);

    if (group != null) {
      context.go(AppRoutes.groupDetail.replaceFirst(':id', group.id));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código inválido ou grupo não encontrado.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrar em grupo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Código de convite',
                  border: OutlineInputBorder(),
                  hintText: 'Ex: ABC123',
                ),
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                validator: (v) =>
                    (v == null || v.trim().length < 6) ? 'Código inválido' : null,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
