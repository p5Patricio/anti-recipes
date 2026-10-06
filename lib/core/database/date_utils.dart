/// Normalizes [value] to local midnight so a calendar day has exactly one
/// representation in the database (unique `(date, slot)`, per-day sums).
DateTime dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);
