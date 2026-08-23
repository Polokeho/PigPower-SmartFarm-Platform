import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/farmer_providers.dart';

/// Farmer onboarding — 5.5 §11's core loop step 4 ("local production +
/// veterinary records created, queued in outbox") applied to farmer
/// creation. Submitting here NEVER blocks on connectivity — the write
/// completes locally immediately, per 5.6 FR-MOB-011.
class FarmerCreateScreen extends ConsumerStatefulWidget {
  const FarmerCreateScreen({super.key});

  @override
  ConsumerState<FarmerCreateScreen> createState() => _FarmerCreateScreenState();
}

class _FarmerCreateScreenState extends ConsumerState<FarmerCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _communityController = TextEditingController();
  final _phoneController = TextEditingController();
  String _district = 'BEREA'; // TODO: populate from cached LookupValues (OSDS FR-OSDS-005) once seeded

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(farmerRepositoryProvider).createFarmer(
          name: _nameController.text.trim(),
          districtCode: _district,
          community: _communityController.text.trim().isEmpty ? null : _communityController.text.trim(),
          phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farmer saved. It will sync automatically when online.')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Farmer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _district,
                decoration: const InputDecoration(labelText: 'District'),
                items: const [
                  DropdownMenuItem(value: 'MASERU', child: Text('Maseru')),
                  DropdownMenuItem(value: 'BEREA', child: Text('Berea')),
                ],
                onChanged: (v) => setState(() => _district = v ?? _district),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _communityController,
                decoration: const InputDecoration(labelText: 'Community (optional)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone (optional)'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: _submit, child: const Text('Save Farmer')),
            ],
          ),
        ),
      ),
    );
  }
}
