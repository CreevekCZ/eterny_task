import 'package:eterny_task/features/home/models/character.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/character_row.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/nemesis_table.dart';
import 'package:flutter/material.dart';

class CharacterRowWithChildren extends StatelessWidget {
  const CharacterRowWithChildren({
    required this.character,
    required this.expandedItems,
    required this.onToggleExpansion,
    this.onDeleteCharacter,
    this.onDeleteNemesis,
    this.onDeleteSecret,
    super.key,
  });

  final Character character;
  final Set<String> expandedItems;
  final ValueChanged<String> onToggleExpansion;

  final OnDeleteCharacter? onDeleteCharacter;
  final OnDeleteNemesis? onDeleteNemesis;
  final OnDeleteSecret? onDeleteSecret;

  void _onDeleteNemesis(int nemesisId) {
    onDeleteNemesis?.call(character.uuid, nemesisId);
  }

  void _onDeleteSecret(int nemesisId, int secretId) {
    onDeleteSecret?.call(character.uuid, secretId, nemesisId);
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = expandedItems.contains('character_${character.uuid}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterRow(
          character: character,
          isExpanded: isExpanded,
          onToggleExpansion: onToggleExpansion,
          onDeleteCharacter: onDeleteCharacter,
          onDeleteNemesis: onDeleteNemesis,
          onDeleteSecret: onDeleteSecret,
        ),
        if (isExpanded && character.nemeses.isNotEmpty)
          NemesisTable(
            nemeses: character.nemeses,
            expandedItems: expandedItems,
            onToggleExpansion: onToggleExpansion,
            onDeleteNemesis: _onDeleteNemesis,
            onDeleteSecret: _onDeleteSecret,
          ),
      ],
    );
  }
}
