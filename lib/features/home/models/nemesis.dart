import 'package:eterny_task/features/home/models/secret.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nemesis.freezed.dart';

@freezed
class Nemesis with _$Nemesis {
  const factory Nemesis({
    required int id,
    required int characterId,
    required bool isAlive,
    String? years,
    @Default([]) List<Secret> secrets,
  }) = _Nemesis;

  factory Nemesis.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final children = json['children'] as Map<String, dynamic>? ?? {};

    List<Secret> secrets = [];
    if (children.containsKey('has_secrete')) {
      final hasSecret = children['has_secrete'] as Map<String, dynamic>;
      if (hasSecret.containsKey('records')) {
        final records = hasSecret['records'] as List<dynamic>;
        secrets = records.map((record) => Secret.fromJson(record as Map<String, dynamic>)).toList();
      }
    }

    return Nemesis(
      id: int.parse(data['ID'] as String),
      characterId: int.parse(data['Character ID'] as String),
      isAlive: data['Is alive?'] == 'true',
      years: data['Years'] as String?,
      secrets: secrets,
    );
  }
}
