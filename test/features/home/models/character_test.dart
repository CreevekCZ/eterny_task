import 'package:eterny_task/features/home/models/character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest_10y.dart' as tz;

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
  });

  group('Character.fromJson', () {
    test('should parse character without nemeses correctly', () {
      final json = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '48',
          'Name': 'Zaphod Beeblebrox',
          'Gender': 'm',
          'Ability': 'semi_half_cousin',
          'Minimal distance': '1.6000000000',
          'Weight': '91',
          'Born': 'Mon Feb 17 00:00:00 CET 1997',
          'In space since': 'Wed Dec 04 04:09:55 CET 2014',
          'Beer consumption (l/y)': '679420',
          'Knows the answer?': 'true',
        },
        'children': <String, dynamic>{},
      };

      final character = Character.fromJson(json);

      expect(character.id, 48);
      expect(character.name, 'Zaphod Beeblebrox');
      expect(character.gender, 'm');
      expect(character.ability, 'semi_half_cousin');
      expect(character.minimalDistance, '1.6000000000');
      expect(character.weight, 91.0);
      expect(character.born.year, 1997);
      expect(character.born.month, 2);
      expect(character.born.day, 17);
      expect(character.inSpaceSince.year, 2014);
      expect(character.inSpaceSince.month, 12);
      expect(character.inSpaceSince.day, 4);
      expect(character.beerConsumption, 679420);
      expect(character.knowsTheAnswer, true);
      expect(character.nemeses, isEmpty);
      expect(character.canExpand, false);
      expect(character.numberOfNemeses, 0);
      expect(character.numberOfSecrets, 0);
      expect(character.uuid, isNotEmpty);
    });

    test('should parse character with nemeses and secrets correctly', () {
      final json = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '44',
          'Name': 'Trillian',
          'Gender': 'female',
          'Ability': 'mathematician',
          'Minimal distance': '6.2000000000',
          'Weight': '49',
          'Born': 'Mon Dec 14 00:00:00 CET 1994',
          'In space since': 'Wed Dec 24 17:21:50 CET 2014',
          'Beer consumption (l/y)': '6704',
          'Knows the answer?': 'true',
        },
        'children': <String, dynamic>{
          'has_nemesis': <String, dynamic>{
            'records': <dynamic>[
              <String, dynamic>{
                'data': <String, dynamic>{
                  'ID': '1007',
                  'Character ID': '44',
                  'Is alive?': 'true',
                  'Years': '29',
                },
                'children': <String, dynamic>{
                  'has_secrete': <String, dynamic>{
                    'records': <dynamic>[
                      <String, dynamic>{
                        'data': <String, dynamic>{
                          'ID': '2008',
                          'Nemesis ID': '1007',
                          'Secrete Code': '1799820570',
                        },
                        'children': <String, dynamic>{},
                      },
                    ],
                  },
                },
              },
            ],
          },
        },
      };

      final character = Character.fromJson(json);

      expect(character.id, 44);
      expect(character.name, 'Trillian');
      expect(character.gender, 'female');
      expect(character.ability, 'mathematician');
      expect(character.nemeses, hasLength(1));
      expect(character.canExpand, true);
      expect(character.numberOfNemeses, 1);
      expect(character.numberOfSecrets, 1);

      final nemesis = character.nemeses.first;
      expect(nemesis.id, 1007);
      expect(nemesis.characterId, 44);
      expect(nemesis.isAlive, true);
      expect(nemesis.years, '29');
      expect(nemesis.secrets, hasLength(1));

      final secret = nemesis.secrets.first;
      expect(secret.id, 2008);
      expect(secret.nemesisId, 1007);
      expect(secret.secreteCode, '1799820570');
    });

    test('should parse character with multiple nemeses and multiple secrets correctly', () {
      final json = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '52',
          'Name': 'Ford Prefect',
          'Gender': 'M',
          'Ability': 'has_towel',
          'Minimal distance': '0.8000000000',
          'Weight': '107',
          'Born': 'Thu May 41 00:00:00 CET 2001',
          'In space since': 'Sun Dec 21 11:57:06 CET 2014',
          'Beer consumption (l/y)': '62544',
          'Knows the answer?': 'true',
        },
        'children': <String, dynamic>{
          'has_nemesis': <String, dynamic>{
            'records': <dynamic>[
              <String, dynamic>{
                'data': <String, dynamic>{
                  'ID': '1684',
                  'Character ID': '52',
                  'Is alive?': 'true',
                  'Years': '28',
                },
                'children': <String, dynamic>{
                  'has_secrete': <String, dynamic>{
                    'records': <dynamic>[
                      <String, dynamic>{
                        'data': <String, dynamic>{
                          'ID': '1404',
                          'Nemesis ID': '1684',
                          'Secrete Code': '5464826016',
                        },
                        'children': <String, dynamic>{},
                      },
                      <String, dynamic>{
                        'data': <String, dynamic>{
                          'ID': '1415',
                          'Nemesis ID': '1684',
                          'Secrete Code': '6270976449',
                        },
                        'children': <String, dynamic>{},
                      },
                    ],
                  },
                },
              },
              <String, dynamic>{
                'data': <String, dynamic>{
                  'ID': '1685',
                  'Character ID': '52',
                  'Is alive?': 'false',
                  'Years': '30',
                },
                'children': <String, dynamic>{
                  'has_secrete': <String, dynamic>{
                    'records': <dynamic>[
                      <String, dynamic>{
                        'data': <String, dynamic>{
                          'ID': '2505',
                          'Nemesis ID': '1685',
                          'Secrete Code': '7899028241',
                        },
                        'children': <String, dynamic>{},
                      },
                    ],
                  },
                },
              },
            ],
          },
        },
      };

      final character = Character.fromJson(json);

      expect(character.numberOfNemeses, 2);
      expect(character.numberOfSecrets, 3);
      expect(character.canExpand, true);

      final firstNemesis = character.nemeses[0];
      expect(firstNemesis.id, 1684);
      expect(firstNemesis.isAlive, true);
      expect(firstNemesis.secrets, hasLength(2));

      final secondNemesis = character.nemeses[1];
      expect(secondNemesis.id, 1685);
      expect(secondNemesis.isAlive, false);
      expect(secondNemesis.secrets, hasLength(1));
    });

    test('should handle optional fields correctly when they are null', () {
      // Given
      final json = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '100',
          'Name': 'Test Character',
          'Gender': null,
          'Ability': null,
          'Minimal distance': '5.0000000000',
          'Weight': '70',
          'Born': 'Mon Jan 01 00:00:00 UTC 2000',
          'In space since': 'Mon Jan 01 00:00:00 UTC 2020',
          'Beer consumption (l/y)': '100',
          'Knows the answer?': 'false',
        },
        'children': <String, dynamic>{},
      };

      final character = Character.fromJson(json);

      expect(character.gender, isNull);
      expect(character.ability, isNull);
      expect(character.name, 'Test Character');
      expect(character.knowsTheAnswer, false);
    });

    test('should handle missing children key correctly', () {
      final json = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '101',
          'Name': 'Character Without Children',
          'Gender': 'unknown',
          'Ability': 'test',
          'Minimal distance': '3.0000000000',
          'Weight': '60',
          'Born': 'Tue Jan 01 00:00:00 UTC 2001',
          'In space since': 'Tue Jan 01 00:00:00 UTC 2021',
          'Beer consumption (l/y)': '50',
          'Knows the answer?': 'true',
        },
      };

      final character = Character.fromJson(json);

      expect(character.nemeses, isEmpty);
      expect(character.canExpand, false);
      expect(character.numberOfNemeses, 0);
      expect(character.numberOfSecrets, 0);
    });

    test('should handle nemesis without secrets correctly', () {
      final json = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '102',
          'Name': 'Character with Nemesis No Secrets',
          'Gender': 'other',
          'Ability': 'mysterious',
          'Minimal distance': '2.5000000000',
          'Weight': '80',
          'Born': 'Wed Jan 01 00:00:00 UTC 2002',
          'In space since': 'Wed Jan 01 00:00:00 UTC 2022',
          'Beer consumption (l/y)': '200',
          'Knows the answer?': 'false',
        },
        'children': <String, dynamic>{
          'has_nemesis': <String, dynamic>{
            'records': <dynamic>[
              <String, dynamic>{
                'data': <String, dynamic>{
                  'ID': '2000',
                  'Character ID': '102',
                  'Is alive?': 'true',
                  'Years': '25',
                },
                'children': <String, dynamic>{},
              },
            ],
          },
        },
      };

      final character = Character.fromJson(json);

      expect(character.nemeses, hasLength(1));
      expect(character.numberOfNemeses, 1);
      expect(character.numberOfSecrets, 0);
      expect(character.nemeses.first.secrets, isEmpty);
    });

    test('should handle nemesis with missing years field correctly', () {
      final json = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '103',
          'Name': 'Test Character',
          'Gender': 'test',
          'Ability': 'test',
          'Minimal distance': '1.0000000000',
          'Weight': '50',
          'Born': 'Thu Jan 01 00:00:00 UTC 2003',
          'In space since': 'Thu Jan 01 00:00:00 UTC 2023',
          'Beer consumption (l/y)': '300',
          'Knows the answer?': 'true',
        },
        'children': <String, dynamic>{
          'has_nemesis': <String, dynamic>{
            'records': <dynamic>[
              <String, dynamic>{
                'data': <String, dynamic>{
                  'ID': '3000',
                  'Character ID': '103',
                  'Is alive?': 'false',
                },
                'children': <String, dynamic>{},
              },
            ],
          },
        },
      };

      final character = Character.fromJson(json);

      expect(character.nemeses, hasLength(1));
      expect(character.nemeses.first.years, isNull);
      expect(character.nemeses.first.isAlive, false);
    });

    test('should parse different boolean values for knowsTheAnswer correctly', () {
      final jsonFalse = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '104',
          'Name': 'False Answer Character',
          'Gender': 'test',
          'Ability': 'test',
          'Minimal distance': '1.0000000000',
          'Weight': '50',
          'Born': 'Fri Jan 01 00:00:00 UTC 2004',
          'In space since': 'Fri Jan 01 00:00:00 UTC 2024',
          'Beer consumption (l/y)': '400',
          'Knows the answer?': 'false',
        },
        'children': <String, dynamic>{},
      };

      final characterFalse = Character.fromJson(jsonFalse);

      expect(characterFalse.knowsTheAnswer, false);

      final jsonOther = Map<String, dynamic>.from(jsonFalse);
      (jsonOther['data'] as Map<String, dynamic>)['Knows the answer?'] = 'maybe';

      final characterOther = Character.fromJson(jsonOther);

      expect(characterOther.knowsTheAnswer, false);
    });

    test('should generate unique UUIDs for different characters', () {
      final json1 = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '105',
          'Name': 'Character 1',
          'Gender': 'test',
          'Ability': 'test',
          'Minimal distance': '1.0000000000',
          'Weight': '50',
          'Born': 'Sat Jan 01 00:00:00 UTC 2005',
          'In space since': 'Sat Jan 01 00:00:00 UTC 2025',
          'Beer consumption (l/y)': '500',
          'Knows the answer?': 'true',
        },
        'children': <String, dynamic>{},
      };

      final json2 = <String, dynamic>{
        'data': <String, dynamic>{
          'ID': '106',
          'Name': 'Character 2',
          'Gender': 'test',
          'Ability': 'test',
          'Minimal distance': '2.0000000000',
          'Weight': '60',
          'Born': 'Sun Jan 01 00:00:00 UTC 2006',
          'In space since': 'Sun Jan 01 00:00:00 UTC 2026',
          'Beer consumption (l/y)': '600',
          'Knows the answer?': 'false',
        },
        'children': <String, dynamic>{},
      };

      final character1 = Character.fromJson(json1);
      final character2 = Character.fromJson(json2);

      expect(character1.uuid, isNotEmpty);
      expect(character2.uuid, isNotEmpty);
      expect(character1.uuid, isNot(equals(character2.uuid)));
    });
  });
}
