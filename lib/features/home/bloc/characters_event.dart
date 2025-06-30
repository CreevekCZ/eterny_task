import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters_event.freezed.dart';

@freezed
sealed class CharactersEvent with _$CharactersEvent {
  const factory CharactersEvent.loadCharacters() = CharactersLoadCharactersEvent;

  const factory CharactersEvent.deleteCharacter({
    required String uuid,
  }) = CharactersDeleteCharacterEvent;

  const factory CharactersEvent.deleteNemesis({
    required String uuid,
    required int nemesisId,
  }) = CharactersDeleteNemesisEvent;

  const factory CharactersEvent.deleteSecret({
    required String uuid,
    required int secretId,
    required int nemesisId,
  }) = CharactersDeleteSecretEvent;
}
