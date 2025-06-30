import 'package:eterny_task/features/home/bloc/characters_event.dart';
import 'package:eterny_task/features/home/bloc/characters_state.dart';
import 'package:eterny_task/features/home/models/character.dart';
import 'package:eterny_task/features/home/models/nemesis.dart';
import 'package:eterny_task/features/home/services/character_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
final class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc(this._characterService) : super(const CharactersState.loading()) {
    on<CharactersEvent>(
      (event, emit) => event.maybeMap(
        deleteCharacter: (event) => _handleDeleteCharacter(event, emit),
        deleteNemesis: (event) => _handleDeleteNemesis(event, emit),
        deleteSecret: (event) => _handleDeleteSecret(event, emit),
        loadCharacters: (event) => _handleLoadCharacters(event, emit),
        orElse: () => throw UnimplementedError('Unknown event: $event'),
      ),
    );
  }

  final CharacterService _characterService;

  Future<void> _handleLoadCharacters(
    CharactersLoadCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(const CharactersState.loading());

    try {
      final characters = await _characterService.getCharacters();

      emit(CharactersState.loaded(characters: characters));
    } catch (e) {
      emit(CharactersState.error(message: e.toString()));
    }
  }

  Future<void> _handleDeleteCharacter(
    CharactersDeleteCharacterEvent event,
    Emitter<CharactersState> emit,
  ) async {
    final currentCharacters = state.maybeCharacters;
    if (currentCharacters.isEmpty) {
      return;
    }

    emit(CharactersState.loading(characters: currentCharacters));

    final updatedCharacters = currentCharacters
        .where((character) => character.uuid != event.uuid)
        .toList();

    emit(CharactersState.loaded(characters: updatedCharacters));
  }

  Future<void> _handleDeleteNemesis(
    CharactersDeleteNemesisEvent event,
    Emitter<CharactersState> emit,
  ) async {
    final currentCharacters = state.maybeCharacters;
    if (currentCharacters.isEmpty) {
      return;
    }

    emit(CharactersState.loading(characters: currentCharacters));

    final targetIndex = currentCharacters.indexWhere((c) => c.uuid == event.uuid);
    if (targetIndex == -1) {
      return;
    }

    final targetCharacter = currentCharacters[targetIndex];

    final updatedCharacter = targetCharacter.copyWith(
      nemeses: targetCharacter.nemeses.where((n) => n.id != event.nemesisId).toList(),
    );

    // Create new list with updated character
    final updatedCharacters = List<Character>.from(currentCharacters);
    updatedCharacters[targetIndex] = updatedCharacter;

    emit(CharactersState.loaded(characters: updatedCharacters));
  }

  Future<void> _handleDeleteSecret(
    CharactersDeleteSecretEvent event,
    Emitter<CharactersState> emit,
  ) async {
    final currentCharacters = state.maybeCharacters;
    if (currentCharacters.isEmpty) {
      return;
    }

    emit(CharactersState.loading(characters: currentCharacters));

    final targetCharacterIndex = currentCharacters.indexWhere((c) => c.uuid == event.uuid);
    if (targetCharacterIndex == -1) {
      return;
    }

    final targetCharacter = currentCharacters[targetCharacterIndex];
    final targetNemesisIndex = targetCharacter.nemeses.indexWhere((n) => n.id == event.nemesisId);
    if (targetNemesisIndex == -1) {
      return;
    }

    final targetNemesis = targetCharacter.nemeses[targetNemesisIndex];

    final updatedNemesis = targetNemesis.copyWith(
      secrets: targetNemesis.secrets.where((s) => s.id != event.secretId).toList(),
    );

    final updatedNemeses = List<Nemesis>.from(targetCharacter.nemeses);
    updatedNemeses[targetNemesisIndex] = updatedNemesis;

    final updatedCharacter = targetCharacter.copyWith(nemeses: updatedNemeses);

    final updatedCharacters = List<Character>.from(currentCharacters);
    updatedCharacters[targetCharacterIndex] = updatedCharacter;

    emit(CharactersState.loaded(characters: updatedCharacters));
  }
}
