import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../models/character.dart';

@injectable
class CharacterService {
  Future<List<Character>> getCharacters() async {
    try {
      final json = await rootBundle.loadString('assets/data/data.json');
      final data = jsonDecode(json) as List<dynamic>;

      // own keys not using character id, values can be duplicated
      final characters = <Character>[];
      for (int i = 0; i < data.length; i++) {
        final character = Character.fromJson(data[i] as Map<String, dynamic>);
        characters.add(character);
      }

      return characters;
    } catch (e) {
      // Handle error gracefully
      return [];
    }
  }
}
