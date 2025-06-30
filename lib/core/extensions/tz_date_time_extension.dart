import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

extension TZDateTimeX on tz.TZDateTime {
  static tz.Location getLocationFromAbbrev(String timeZoneCode) => switch (timeZoneCode) {
    'CET' => tz.getLocation('Europe/Warsaw'),
    'CEST' => tz.getLocation('Europe/Warsaw'),
    'EET' => tz.getLocation('Europe/Bucharest'),
    'EEST' => tz.getLocation('Europe/Bucharest'),
    'EST' => tz.getLocation('America/New_York'),
    'EAST' => tz.getLocation('America/New_York'), // Note: 'EAST' is not standard for New York
    'EDT' => tz.getLocation('America/New_York'),
    'CST' => tz.getLocation('America/Chicago'),
    'CDT' => tz.getLocation('America/Chicago'),
    'MST' => tz.getLocation('America/Denver'),
    'MDT' => tz.getLocation('America/Denver'),
    'PST' => tz.getLocation('America/Los_Angeles'),
    'PDT' => tz.getLocation('America/Los_Angeles'),
    'HST' => tz.getLocation('Pacific/Honolulu'),
    'HDT' => tz.getLocation('Pacific/Honolulu'), // Note: HDT is rare
    'AKST' => tz.getLocation('America/Anchorage'),
    'AKDT' => tz.getLocation('America/Anchorage'),
    'AST' => tz.getLocation('America/Halifax'),
    'ADT' => tz.getLocation('America/Halifax'),
    'NST' => tz.getLocation('America/St_Johns'),
    'NDT' => tz.getLocation('America/St_Johns'),
    'AEST' => tz.getLocation('Australia/Sydney'),
    'AEDT' => tz.getLocation('Australia/Sydney'),
    'ACST' => tz.getLocation('Australia/Adelaide'),
    'ACDT' => tz.getLocation('Australia/Adelaide'),
    'AWST' => tz.getLocation('Australia/Perth'),
    'AWDT' => tz.getLocation('Australia/Perth'),
    'NZST' => tz.getLocation('Pacific/Auckland'),
    'NZDT' => tz.getLocation('Pacific/Auckland'),
    'IST' => tz.getLocation('Asia/Kolkata'),
    'JST' => tz.getLocation('Asia/Tokyo'),
    'KST' => tz.getLocation('Asia/Seoul'),
    'WET' => tz.getLocation('Europe/Lisbon'),
    'WEST' => tz.getLocation('Europe/Lisbon'),
    'BST' => tz.getLocation('Europe/London'),
    'GMT' => tz.getLocation('Europe/London'), // Or 'UTC' if you prefer
    'UTC' => tz.getLocation('UTC'),
    'MSK' => tz.getLocation('Europe/Moscow'),
    'SAST' => tz.getLocation('Africa/Johannesburg'),
    'CAT' => tz.getLocation('Africa/Harare'),
    'EAT' => tz.getLocation('Africa/Nairobi'),
    'SGT' => tz.getLocation('Asia/Singapore'),
    'HKT' => tz.getLocation('Asia/Hong_Kong'),
    'PHT' => tz.getLocation('Asia/Manila'),
    'TRT' => tz.getLocation('Europe/Istanbul'),
    'IRST' => tz.getLocation('Asia/Tehran'),
    'IDT' => tz.getLocation('Asia/Jerusalem'),
    _ => throw ArgumentError('Invalid time zone code: $timeZoneCode'),
  };

  /// Gets timezone abbreviation from location name
  static String _getAbbrevFromLocation(tz.Location location) => switch (location.name) {
    'Europe/Warsaw' => 'CET',
    'Europe/Bucharest' => 'EET',
    'America/New_York' => 'EST',
    'America/Chicago' => 'CST',
    'America/Denver' => 'MST',
    'America/Los_Angeles' => 'PST',
    'Pacific/Honolulu' => 'HST',
    'America/Anchorage' => 'AKST',
    'America/Halifax' => 'AST',
    'America/St_Johns' => 'NST',
    'Australia/Sydney' => 'AEST',
    'Australia/Adelaide' => 'ACST',
    'Australia/Perth' => 'AWST',
    'Pacific/Auckland' => 'NZST',
    'Asia/Kolkata' => 'IST',
    'Asia/Tokyo' => 'JST',
    'Asia/Seoul' => 'KST',
    'Europe/Lisbon' => 'WET',
    'Europe/London' => 'GMT',
    'UTC' => 'UTC',
    'Europe/Moscow' => 'MSK',
    'Africa/Johannesburg' => 'SAST',
    'Africa/Harare' => 'CAT',
    'Africa/Nairobi' => 'EAT',
    'Asia/Singapore' => 'SGT',
    'Asia/Hong_Kong' => 'HKT',
    'Asia/Manila' => 'PHT',
    'Europe/Istanbul' => 'TRT',
    'Asia/Tehran' => 'IRST',
    'Asia/Jerusalem' => 'IDT',
    _ => 'UTC',
  };

  /// Parses a custom datetime format: "Wed Dec 24 17:21:50 CET 2014"
  static tz.TZDateTime fromProprietaryDateFormat(String dateStr) {
    final parts = dateStr.split(' ');
    if (parts.length < 6) {
      throw ArgumentError('Invalid date format: $dateStr');
    }

    final months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };

    final monthName = parts[1];
    final month = months[monthName];
    if (month == null) {
      throw ArgumentError('Invalid month: $monthName');
    }

    final day = int.tryParse(parts[2]);
    if (day == null) {
      throw ArgumentError('Invalid day: ${parts[2]}');
    }

    final timeParts = parts[3].split(':');
    if (timeParts.length < 3) {
      throw ArgumentError('Invalid time format: ${parts[3]}');
    }

    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);
    final second = int.tryParse(timeParts[2]);

    if (hour == null || minute == null || second == null) {
      throw ArgumentError('Invalid time: ${parts[3]}');
    }

    final timeZone = parts[4];
    final year = int.tryParse(parts[5]);
    if (year == null) {
      throw ArgumentError('Invalid year: ${parts[5]}');
    }

    final location = getLocationFromAbbrev(timeZone);

    return tz.TZDateTime(
      location,
      year,
      month,
      day,
      hour,
      minute,
      second,
    );
  }

  /// Example: "Wed Dec 24 17:21:50 CET 2014"
  String get toProprietaryDateFormat {
    final formatter = DateFormat('EEE MMM d HH:mm:ss');
    final timeZoneAbbrev = _getAbbrevFromLocation(location);
    return '${formatter.format(this)} $timeZoneAbbrev $year';
  }
}
