import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret.freezed.dart';

@freezed
class Secret with _$Secret {
  const factory Secret({
    required int id,
    required int nemesisId,
    required String secreteCode,
  }) = _Secret;

  factory Secret.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return Secret(
      id: int.parse(data['ID'] as String),
      nemesisId: int.parse(data['Nemesis ID'] as String),
      secreteCode: data['Secrete Code'] as String,
    );
  }
}
