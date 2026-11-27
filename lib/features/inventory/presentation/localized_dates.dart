import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// "Oct 6" in English, "6 oct" in Spanish.
String localizedShortDate(BuildContext context, DateTime d) =>
    DateFormat.MMMd(Localizations.localeOf(context).toString()).format(d);

/// "Tue, Oct 6" in English, "mar, 6 oct" in Spanish.
String localizedWeekdayDate(BuildContext context, DateTime d) =>
    DateFormat.MMMEd(Localizations.localeOf(context).toString()).format(d);
