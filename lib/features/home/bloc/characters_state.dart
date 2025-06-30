import 'package:eterny_task/features/home/models/character.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters_state.freezed.dart';

@freezed
sealed class CharactersState with _$CharactersState {
  const factory CharactersState.initial() = CharactersInitialState;

  const factory CharactersState.loading({
    @Default([]) List<Character> characters,
  }) = CharactersLoadingState;

  const factory CharactersState.loaded({
    @Default([]) List<Character> characters,
  }) = CharactersLoadedState;

  const CharactersState._();

  List<Character> get maybeCharacters => maybeMap(
    loaded: (state) => state.characters,
    loading: (state) => state.characters,
    orElse: () => const [],
  );
}
