import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../domain/nutrition_plan.dart';
import 'targets_form.dart';

class _TargetsFormData {
  const _TargetsFormData(this.plan, this.schedule, this.weightKg);
  final NutritionPlan plan;
  final WeekSchedule schedule;
  final double? weightKg;
}

/// One-shot load (not a stream) so saving never rewrites the form under the user.
final _formDataProvider = FutureProvider.autoDispose<_TargetsFormData>((
  ref,
) async {
  final dao = ref.watch(targetsDaoProvider);
  return _TargetsFormData(
    await dao.loadPlan() ?? NutritionPlan.exampleDefaults(),
    await dao.loadSchedule() ?? WeekSchedule.exampleDefaults(),
    await dao.loadBodyWeightKg(),
  );
});

class NutritionTargetsScreen extends ConsumerWidget {
  const NutritionTargetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(_formDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Nutrition targets')),
      body: data.when(
        data: (d) => TargetsForm(
          initialPlan: d.plan,
          initialSchedule: d.schedule,
          initialWeightKg: d.weightKg,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load targets: $e')),
      ),
    );
  }
}
