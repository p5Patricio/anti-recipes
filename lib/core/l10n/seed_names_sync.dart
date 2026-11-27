import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_provider.dart';
import '../database/seed_names.dart';

/// Keeps the seeded ingredient and tool names in the language the app is
/// showing: runs once on startup and again whenever the effective locale
/// changes. It renders [child] unchanged.
class SeedNamesSync extends ConsumerStatefulWidget {
  const SeedNamesSync({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<SeedNamesSync> createState() => _SeedNamesSyncState();
}

class _SeedNamesSyncState extends ConsumerState<SeedNamesSync> {
  String? _syncedFor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final code = Localizations.localeOf(context).languageCode;
    if (code == _syncedFor) return;
    _syncedFor = code;
    unawaited(syncSeedNames(ref.read(appDatabaseProvider), code));
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
