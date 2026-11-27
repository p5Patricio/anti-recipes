import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Set<String> _messageKeys(String path) {
  final map = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return map.keys.where((k) => !k.startsWith('@')).toSet();
}

void main() {
  test('English and Spanish ARB files define the same message keys', () {
    final en = _messageKeys('lib/l10n/app_en.arb');
    final es = _messageKeys('lib/l10n/app_es.arb');
    expect(es.difference(en), isEmpty, reason: 'keys only in Spanish');
    expect(en.difference(es), isEmpty, reason: 'keys only in English');
  });
}
