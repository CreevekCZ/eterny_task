import 'package:eterny_task/core/extensions/tz_date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
  });

  group('TZDateTimeX Extension Tests', () {
    test('should return correct location for European time zones', () {
      expect(TZDateTimeX.getLocationFromAbbrev('CET').name, 'Europe/Warsaw');
      expect(TZDateTimeX.getLocationFromAbbrev('CEST').name, 'Europe/Warsaw');
      expect(TZDateTimeX.getLocationFromAbbrev('EET').name, 'Europe/Bucharest');
      expect(TZDateTimeX.getLocationFromAbbrev('EEST').name, 'Europe/Bucharest');
      expect(TZDateTimeX.getLocationFromAbbrev('WET').name, 'Europe/Lisbon');
      expect(TZDateTimeX.getLocationFromAbbrev('WEST').name, 'Europe/Lisbon');
      expect(TZDateTimeX.getLocationFromAbbrev('BST').name, 'Europe/London');
      expect(TZDateTimeX.getLocationFromAbbrev('GMT').name, 'Europe/London');
      expect(TZDateTimeX.getLocationFromAbbrev('MSK').name, 'Europe/Moscow');
      expect(TZDateTimeX.getLocationFromAbbrev('TRT').name, 'Europe/Istanbul');
    });

    test('should return correct location for American time zones', () {
      expect(TZDateTimeX.getLocationFromAbbrev('EST').name, 'America/New_York');
      expect(TZDateTimeX.getLocationFromAbbrev('EDT').name, 'America/New_York');
      expect(TZDateTimeX.getLocationFromAbbrev('CST').name, 'America/Chicago');
      expect(TZDateTimeX.getLocationFromAbbrev('CDT').name, 'America/Chicago');
      expect(TZDateTimeX.getLocationFromAbbrev('MST').name, 'America/Denver');
      expect(TZDateTimeX.getLocationFromAbbrev('MDT').name, 'America/Denver');
      expect(TZDateTimeX.getLocationFromAbbrev('PST').name, 'America/Los_Angeles');
      expect(TZDateTimeX.getLocationFromAbbrev('PDT').name, 'America/Los_Angeles');
      expect(TZDateTimeX.getLocationFromAbbrev('AKST').name, 'America/Anchorage');
      expect(TZDateTimeX.getLocationFromAbbrev('AKDT').name, 'America/Anchorage');
      expect(TZDateTimeX.getLocationFromAbbrev('AST').name, 'America/Halifax');
      expect(TZDateTimeX.getLocationFromAbbrev('ADT').name, 'America/Halifax');
      expect(TZDateTimeX.getLocationFromAbbrev('NST').name, 'America/St_Johns');
      expect(TZDateTimeX.getLocationFromAbbrev('NDT').name, 'America/St_Johns');
    });

    test('should return correct location for Pacific time zones', () {
      expect(TZDateTimeX.getLocationFromAbbrev('HST').name, 'Pacific/Honolulu');
      expect(TZDateTimeX.getLocationFromAbbrev('HDT').name, 'Pacific/Honolulu');
      expect(TZDateTimeX.getLocationFromAbbrev('NZST').name, 'Pacific/Auckland');
      expect(TZDateTimeX.getLocationFromAbbrev('NZDT').name, 'Pacific/Auckland');
    });

    test('should return correct location for Australian time zones', () {
      expect(TZDateTimeX.getLocationFromAbbrev('AEST').name, 'Australia/Sydney');
      expect(TZDateTimeX.getLocationFromAbbrev('AEDT').name, 'Australia/Sydney');
      expect(TZDateTimeX.getLocationFromAbbrev('ACST').name, 'Australia/Adelaide');
      expect(TZDateTimeX.getLocationFromAbbrev('ACDT').name, 'Australia/Adelaide');
      expect(TZDateTimeX.getLocationFromAbbrev('AWST').name, 'Australia/Perth');
      expect(TZDateTimeX.getLocationFromAbbrev('AWDT').name, 'Australia/Perth');
    });

    test('should return correct location for Asian time zones', () {
      expect(TZDateTimeX.getLocationFromAbbrev('IST').name, 'Asia/Kolkata');
      expect(TZDateTimeX.getLocationFromAbbrev('JST').name, 'Asia/Tokyo');
      expect(TZDateTimeX.getLocationFromAbbrev('KST').name, 'Asia/Seoul');
      expect(TZDateTimeX.getLocationFromAbbrev('SGT').name, 'Asia/Singapore');
      expect(TZDateTimeX.getLocationFromAbbrev('HKT').name, 'Asia/Hong_Kong');
      expect(TZDateTimeX.getLocationFromAbbrev('PHT').name, 'Asia/Manila');
      expect(TZDateTimeX.getLocationFromAbbrev('IRST').name, 'Asia/Tehran');
      expect(TZDateTimeX.getLocationFromAbbrev('IDT').name, 'Asia/Jerusalem');
    });

    test('should return correct location for African time zones', () {
      expect(TZDateTimeX.getLocationFromAbbrev('SAST').name, 'Africa/Johannesburg');
      expect(TZDateTimeX.getLocationFromAbbrev('CAT').name, 'Africa/Harare');
      expect(TZDateTimeX.getLocationFromAbbrev('EAT').name, 'Africa/Nairobi');
    });

    test('should return UTC location for UTC time zone', () {
      expect(TZDateTimeX.getLocationFromAbbrev('UTC').name, 'UTC');
    });

    test('should throw ArgumentError for invalid time zone code', () {
      expect(
        () => TZDateTimeX.getLocationFromAbbrev('INVALID'),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Invalid time zone code: INVALID',
          ),
        ),
      );
    });

    group('fromProprietaryDateFormat', () {
      test('should parse valid date string correctly', () {
        const dateStr = 'Wed Dec 24 17:21:50 CET 2014';
        final result = TZDateTimeX.fromProprietaryDateFormat(dateStr);

        expect(result.year, 2014);
        expect(result.month, 12);
        expect(result.day, 24);
        expect(result.hour, 17);
        expect(result.minute, 21);
        expect(result.second, 50);
        expect(result.location.name, 'Europe/Warsaw'); // CET maps to Europe/Warsaw
      });

      test('should parse different months correctly', () {
        const testCases = [
          ('Mon Jan 01 12:00:00 UTC 2023', 1),
          ('Tue Feb 14 12:00:00 UTC 2023', 2),
          ('Wed Mar 15 12:00:00 UTC 2023', 3),
          ('Thu Apr 20 12:00:00 UTC 2023', 4),
          ('Fri May 25 12:00:00 UTC 2023', 5),
          ('Sat Jun 30 12:00:00 UTC 2023', 6),
          ('Sun Jul 04 12:00:00 UTC 2023', 7),
          ('Mon Aug 15 12:00:00 UTC 2023', 8),
          ('Tue Sep 26 12:00:00 UTC 2023', 9),
          ('Wed Oct 31 12:00:00 UTC 2023', 10),
          ('Thu Nov 23 12:00:00 UTC 2023', 11),
          ('Fri Dec 25 12:00:00 UTC 2023', 12),
        ];

        for (final (dateStr, expectedMonth) in testCases) {
          final result = TZDateTimeX.fromProprietaryDateFormat(dateStr);
          expect(result.month, expectedMonth, reason: 'Failed for $dateStr');
        }
      });

      test('should parse different time zones correctly', () {
        const testCases = [
          ('Wed Dec 24 17:21:50 UTC 2014', 'UTC'),
          ('Wed Dec 24 17:21:50 EST 2014', 'America/New_York'),
          ('Wed Dec 24 17:21:50 PST 2014', 'America/Los_Angeles'),
          ('Wed Dec 24 17:21:50 JST 2014', 'Asia/Tokyo'),
        ];

        for (final (dateStr, expectedLocation) in testCases) {
          final result = TZDateTimeX.fromProprietaryDateFormat(dateStr);
          expect(result.location.name, expectedLocation, reason: 'Failed for $dateStr');
        }
      });

      test('should throw ArgumentError for invalid date format with insufficient parts', () {
        expect(
          () => TZDateTimeX.fromProprietaryDateFormat('Wed Dec 24'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid date format: Wed Dec 24',
            ),
          ),
        );
      });

      test('should throw ArgumentError for invalid month', () {
        expect(
          () => TZDateTimeX.fromProprietaryDateFormat('Wed XXX 24 17:21:50 UTC 2014'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid month: XXX',
            ),
          ),
        );
      });

      test('should throw ArgumentError for invalid day', () {
        expect(
          () => TZDateTimeX.fromProprietaryDateFormat('Wed Dec XX 17:21:50 UTC 2014'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid day: XX',
            ),
          ),
        );
      });

      test('should throw ArgumentError for invalid time format', () {
        expect(
          () => TZDateTimeX.fromProprietaryDateFormat('Wed Dec 24 17:21 UTC 2014'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid time format: 17:21',
            ),
          ),
        );
      });

      test('should throw ArgumentError for invalid time values', () {
        expect(
          () => TZDateTimeX.fromProprietaryDateFormat('Wed Dec 24 XX:21:50 UTC 2014'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid time: XX:21:50',
            ),
          ),
        );
      });

      test('should throw ArgumentError for invalid year', () {
        expect(
          () => TZDateTimeX.fromProprietaryDateFormat('Wed Dec 24 17:21:50 UTC XXXX'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid year: XXXX',
            ),
          ),
        );
      });

      test('should throw ArgumentError for invalid time zone', () {
        expect(
          () => TZDateTimeX.fromProprietaryDateFormat('Wed Dec 24 17:21:50 INVALID 2014'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid time zone code: INVALID',
            ),
          ),
        );
      });
    });

    group('toProprietaryDateFormat', () {
      test('should format TZDateTime to proprietary format correctly', () {
        final utcDateTime = tz.TZDateTime(
          tz.getLocation('UTC'),
          2014,
          12,
          24,
          17,
          21,
          50,
        );

        final result = utcDateTime.toProprietaryDateFormat;

        // The exact format should be: "Wed Dec 24 17:21:50 UTC 2014"
        expect(result, matches(r'^\w{3} \w{3} \d{1,2} \d{2}:\d{2}:\d{2} \w+ \d{4}$'));
        expect(result, contains('Dec'));
        expect(result, contains('24'));
        expect(result, contains('17:21:50'));
        expect(result, contains('UTC'));
        expect(result, contains('2014'));
      });

      test('should format different time zones correctly', () {
        final nyDateTime = tz.TZDateTime(
          tz.getLocation('America/New_York'),
          2014,
          12,
          24,
          17,
          21,
          50,
        );

        final result = nyDateTime.toProprietaryDateFormat;

        expect(result, matches(r'^\w{3} \w{3} \d{1,2} \d{2}:\d{2}:\d{2} \w+ \d{4}$'));
        expect(result, contains('Dec'));
        expect(result, contains('24'));
        expect(result, contains('17:21:50'));
        expect(result, contains('EST'));
        expect(result, contains('2014'));
      });

      test('should format single digit days correctly', () {
        final utcDateTime = tz.TZDateTime(
          tz.getLocation('UTC'),
          2014,
          12,
          5,
          17,
          21,
          50,
        );

        final result = utcDateTime.toProprietaryDateFormat;

        expect(result, matches(r'^\w{3} \w{3} \d{1,2} \d{2}:\d{2}:\d{2} \w+ \d{4}$'));
        expect(result, contains('5'));
        expect(result, contains('Dec'));
        expect(result, contains('UTC'));
        expect(result, contains('2014'));
      });

      test('should format different months correctly', () {
        final months = [
          (1, 'Jan'),
          (2, 'Feb'),
          (3, 'Mar'),
          (4, 'Apr'),
          (5, 'May'),
          (6, 'Jun'),
          (7, 'Jul'),
          (8, 'Aug'),
          (9, 'Sep'),
          (10, 'Oct'),
          (11, 'Nov'),
          (12, 'Dec'),
        ];

        for (final (monthNum, monthName) in months) {
          final utcDateTime = tz.TZDateTime(
            tz.getLocation('UTC'),
            2014,
            monthNum,
            15,
            12,
            0,
            0,
          );

          final result = utcDateTime.toProprietaryDateFormat;
          expect(result, contains(monthName), reason: 'Failed for month $monthNum');
        }
      });
    });

    group('Integration tests', () {
      test('should round-trip correctly for various time zones', () {
        final testCases = [
          'Wed Dec 24 17:21:50 UTC 2014',
          'Mon Jan 01 00:00:00 EST 2023',
          'Fri Jul 04 12:30:45 PST 2025',
          'Sun Nov 15 23:59:59 JST 2020',
        ];

        for (final originalDateStr in testCases) {
          final parsed = TZDateTimeX.fromProprietaryDateFormat(originalDateStr);
          final formatted = parsed.toProprietaryDateFormat;

          final reparsed = TZDateTimeX.fromProprietaryDateFormat(formatted);

          expect(reparsed.year, parsed.year, reason: 'Year mismatch for $originalDateStr');
          expect(reparsed.month, parsed.month, reason: 'Month mismatch for $originalDateStr');
          expect(reparsed.day, parsed.day, reason: 'Day mismatch for $originalDateStr');
          expect(reparsed.hour, parsed.hour, reason: 'Hour mismatch for $originalDateStr');
          expect(reparsed.minute, parsed.minute, reason: 'Minute mismatch for $originalDateStr');
          expect(reparsed.second, parsed.second, reason: 'Second mismatch for $originalDateStr');
        }
      });

      test('should handle timezone abbreviation mapping correctly', () {
        final testCases = [
          ('UTC', 'UTC'),
          ('EST', 'America/New_York'),
          ('PST', 'America/Los_Angeles'),
          ('JST', 'Asia/Tokyo'),
          ('CET', 'Europe/Warsaw'),
          ('GMT', 'Europe/London'),
        ];

        for (final (abbrev, locationName) in testCases) {
          final dateStr = 'Wed Dec 24 17:21:50 $abbrev 2014';
          final parsed = TZDateTimeX.fromProprietaryDateFormat(dateStr);

          expect(parsed.location.name, locationName, reason: 'Location mismatch for $abbrev');

          final formatted = parsed.toProprietaryDateFormat;
          expect(formatted, contains(abbrev), reason: 'Abbreviation not preserved for $abbrev');
        }
      });
    });
  });
}
