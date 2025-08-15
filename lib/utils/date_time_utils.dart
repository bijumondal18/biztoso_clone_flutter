import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatChatTimestamp(String isoUtc, {DateTime? now}) {
    // Parse and convert to local time
    final dt = DateTime.parse(isoUtc).toLocal();
    final ref = (now ?? DateTime.now()).toLocal();

    // Strip time for day-diff comparison
    DateTime justDate(DateTime d) => DateTime(d.year, d.month, d.day);
    final diffDays = justDate(ref).difference(justDate(dt)).inDays;

    // Day label: Today / Yesterday / Weekday
    String dayLabel;
    if (diffDays == 0) {
      dayLabel = 'Today';
    } else if (diffDays == 1) {
      dayLabel = 'Yesterday';
    } else {
      dayLabel = DateFormat('EEEE').format(dt); // Monday, Tuesday, ...
    }

    // Time + short date
    final timeStr = DateFormat('h:mm a').format(dt); // e.g., 10:02 AM
    final dateStr = DateFormat('dd MMM').format(dt); // e.g., 06/07/25

    return '$dateStr';
    // return '$timeStr, $dayLabel, $dateStr';
  }
}
