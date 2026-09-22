import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/farmer_providers.dart';
import '../../../../core/lookup/domain/providers/lookup_providers.dart';

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
  // OSDS FR-OSDS-005 — no longer hard-coded. Backed by the local
  // LookupValues cache (see districtListProvider), populated by
  // LookupRepository.refreshFromServer() on login. Null until the
  // user picks one or the cache finishes loading and we default it.
  String? _district;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_district == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a district')),
      );
      return;
    }

    await ref.read(farmerRepositoryProvider).createFarmer(
          name: _nameController.text.trim(),
          districtCode: _district!,
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
              Consumer(
                builder: (context, ref, _) {
                  final districtsAsync = ref.watch(districtListProvider);

                  return districtsAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (err, _) => Text(
                      'Could not load districts. Pull to refresh once online.',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                    data: (districts) {
                      if (districts.isEmpty) {
                        // Cache hasn't been populated yet — e.g. first-ever
                        // login happened offline. There is deliberately no
                        // hard-coded fallback list here (OSDS FR-OSDS-005):
                        // showing stale/wrong districts would silently
                        // mis-assign a farmer's district, which is worse
                        // than asking the user to wait for connectivity.
                        return Text(
                          'No districts cached yet. Connect once to load the district list.',
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      }
                      // Default to the first cached value the first time
                      // data becomes available, without clobbering a
                      // selection the user already made.
                      _district ??= districts.first.code;

                      return DropdownButtonFormField<String>(
                        value: _district,
                        decoration: const InputDecoration(labelText: 'District'),
                        items: districts
                            .map((d) => DropdownMenuItem(value: d.code, child: Text(d.label)))
                            .toList(),
                        onChanged: (v) => setState(() => _district = v),
                      );
                    },
                  );
                },
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
