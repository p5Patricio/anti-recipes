const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

/// "Oct 6".
String shortDate(DateTime d) => '${_months[d.month - 1]} ${d.day}';

/// "Tue, Oct 6".
String weekdayDate(DateTime d) =>
    '${_weekdays[d.weekday - 1]}, ${shortDate(d)}';
