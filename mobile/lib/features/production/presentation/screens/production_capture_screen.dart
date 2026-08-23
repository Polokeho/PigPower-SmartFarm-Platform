import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/production_providers.dart';

/// This screen is the concrete UI behind the OSDS §23 end-to-end
/// scenario: a field user can fill this in and hit Save with zero
/// signal, and it behaves identically to being online — the difference
/// is invisible at this layer, exactly as 5.6 FR-MOB-011 requires.
class ProductionCaptureScreen extends ConsumerStatefulWidget {
  const ProductionCaptureScreen({super.key});

  @override
  ConsumerState<ProductionCaptureScreen> createState() => _ProductionCaptureScreenState();
}

class _ProductionCaptureScreenState extends ConsumerState<ProductionCaptureScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmIdController = TextEditingController(); // TODO: replace with a farm picker fed by local Farmer/Farm cache
  final _pigIdController = TextEditingController();
  final _weightController = TextEditingController();
  final _notesController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(productionRepositoryProvider).recordProduction(
          farmId: _farmIdController.text.trim(),
          pigIds: _pigIdController.text.trim().split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
          weightKg: double.tryParse(_weightController.text.trim()),
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Production entry saved. It will sync automatically when online.')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Production')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _farmIdController,
                decoration: const InputDecoration(labelText: 'Farm ID'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pigIdController,
                decoration: const InputDecoration(labelText: 'Pig ID(s), comma-separated'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg, optional)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: _submit, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
