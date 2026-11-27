import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String _locale(BuildContext context) =>
    Localizations.localeOf(context).toString();

/// "Fri, Nov 27" in the current locale.
String localizedWeekdayDate(BuildContext context, DateTime date) =>
    DateFormat.MMMEd(_locale(context)).format(date);

/// "Nov 27" in the current locale.
String localizedShortDate(BuildContext context, DateTime date) =>
    DateFormat.MMMd(_locale(context)).format(date);
