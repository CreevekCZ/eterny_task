// ignore to persist the freezed model parameters order
// ignore_for_file: always_put_required_named_parameters_first

import 'package:eterny_task/core/extensions/tz_date_time_extension.dart';
import 'package:eterny_task/features/home/models/nemesis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timezone/standalone.dart';
import 'package:uuid/uuid.dart';

part 'character.freezed.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String uuid,
    required int id,
    required String name,
    String? gender,
    String? ability,
    required String minimalDistance,
    required double weight,
    required TZDateTime born,
    required TZDateTime inSpaceSince,
    required int beerConsumption,
    required bool knowsTheAnswer,
    @Default([]) List<Nemesis> nemeses,
  }) = _Character;

  const Character._();

  factory Character.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final children = json['children'] as Map<String, dynamic>? ?? {};

    List<Nemesis> nemeses = [];
    if (children.containsKey('has_nemesis')) {
      final hasNemesis = children['has_nemesis'] as Map<String, dynamic>;
      if (hasNemesis.containsKey('records')) {
        final records = hasNemesis['records'] as List<dynamic>;
        nemeses = records
            .map((record) => Nemesis.fromJson(record as Map<String, dynamic>))
            .toList();
      }
    }

    return Character(
      uuid: const Uuid().v4(),
      id: int.parse(data['ID'] as String),
      name: data['Name'] as String,
      gender: data['Gender'] as String?,
      ability: data['Ability'] as String?,
      minimalDistance: data['Minimal distance'] as String,
      weight: double.parse(data['Weight'] as String),
      born: TZDateTimeX.fromProprietaryDateFormat(data['Born'] as String),
      inSpaceSince: TZDateTimeX.fromProprietaryDateFormat(data['In space since'] as String),
      beerConsumption: int.parse(data['Beer consumption (l/y)'] as String),
      knowsTheAnswer: data['Knows the answer?'] == 'true',
      nemeses: nemeses,
    );
  }

  // Cached computed properties for better performance
  bool get canExpand => nemeses.isNotEmpty;

  int get numberOfNemeses => nemeses.length;

  // Use simple getter for numberOfSecrets - the fold operation is already efficient
  int get numberOfSecrets => nemeses.fold(0, (sum, nemesis) => sum + nemesis.secrets.length);
}
