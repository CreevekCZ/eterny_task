import 'package:eterny_task/features/home/bloc/characters_event.dart';
import 'package:eterny_task/features/home/bloc/characters_state.dart';
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
    final characters = await _characterService.getCharacters();

    emit(CharactersState.loaded(characters: characters));
  }

  Future<void> _handleDeleteCharacter(
    CharactersDeleteCharacterEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersState.loading(characters: state.maybeCharacters));

    final characters = [...state.maybeCharacters];

    characters.removeWhere((character) => character.uuid == event.uuid);

    emit(CharactersState.loaded(characters: characters));
  }

  Future<void> _handleDeleteNemesis(
    CharactersDeleteNemesisEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersState.loading(characters: state.maybeCharacters));

    final characters = [...state.maybeCharacters];

    characters
        .firstWhere((character) => character.uuid == event.uuid)
        .nemeses
        .removeWhere((nemesis) => nemesis.id == event.nemesisId);

    emit(CharactersState.loaded(characters: characters));
  }

  Future<void> _handleDeleteSecret(
    CharactersDeleteSecretEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersState.loading(characters: state.maybeCharacters));

    final characters = [...state.maybeCharacters];

    characters
        .firstWhere((character) => character.uuid == event.uuid)
        .nemeses
        .firstWhere((nemesis) => nemesis.id == event.nemesisId)
        .secrets
        .removeWhere((secret) => secret.id == event.secretId);

    emit(CharactersState.loaded(characters: characters));
  }
}
