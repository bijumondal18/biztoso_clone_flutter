import 'package:intl/intl.dart';

class DateTimeUtils {
  /// Formats an ISO 8601 UTC string like "2025-08-13T06:23:26.541Z"
  /// Rules:
  /// 1) Today -> "10:02 AM"
  /// 2) Yesterday -> "Yesterday"
  /// 3) Day before yesterday -> weekday ("Monday", "Tuesday", ...)
  /// 4) Else -> date "dd/MM/yy"
  static String formatChatTimestamp(String isoUtc, {DateTime? now}) {
    try {
      final dt = DateTime.parse(isoUtc).toLocal();
      final ref = (now ?? DateTime.now()).toLocal();

      DateTime justDate(DateTime d) => DateTime(d.year, d.month, d.day);
      final diffDays = justDate(ref).difference(justDate(dt)).inDays;

      if (diffDays == 0) {
        // Today
        return DateFormat('h:mm a').format(dt);
      } else if (diffDays == 1) {
        // Yesterday
        return 'Yesterday';
      } else if (diffDays == 2) {
        // Day before yesterday -> weekday
        return DateFormat('EEEE').format(dt);
      } else {
        // Everything else -> date only
        return DateFormat('dd MMM').format(dt);
      }
    } catch (_) {
      // Fallback if parsing fails
      return isoUtc;
    }
  }
}
