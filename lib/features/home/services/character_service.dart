import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/data/latest_all.dart';
import '../models/character.dart';

@singleton
class CharacterService {
  List<Character>? _cachedCharacters;

  Future<List<Character>> getCharacters() async {
    if (_cachedCharacters != null) {
      return _cachedCharacters!;
    }

    try {
      final json = await rootBundle.loadString('assets/data/data.json');

      final List<Character> characters;

      characters = await compute(_parseCharactersInIsolate, json);

      _cachedCharacters = characters;
      return characters;
    } catch (_) {
      rethrow;
    }
  }

  void clearCache() {
    _cachedCharacters = null;
  }
}

Future<List<Character>> _parseCharactersInIsolate(String jsonString) async {
  initializeTimeZones();

  final data = jsonDecode(jsonString) as List<dynamic>;
  final characters = <Character>[];

  for (final character in data) {
    characters.add(Character.fromJson(character as Map<String, dynamic>));
  }

  return characters;
}
