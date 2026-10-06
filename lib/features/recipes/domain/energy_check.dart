import '../../../core/nutrition/nutrients.dart';

/// Largest accepted relative gap between declared kcal and 4P + 9F + 4C.
const double energyTolerance = 0.15;

/// True when [kcal] deviates from the macro-implied energy by more than
/// [energyTolerance]. Fiber is ignored, as in the Atwater general factors.
bool kcalDeviatesFromMacros({
  required double kcal,
  required double proteinG,
  required double fatG,
  required double carbsG,
}) {
  final implied = kcalFromMacros(
    proteinG: proteinG,
    fatG: fatG,
    carbsG: carbsG,
  );
  if (implied == 0) return kcal > 0;
  return (kcal - implied).abs() / implied > energyTolerance;
}
