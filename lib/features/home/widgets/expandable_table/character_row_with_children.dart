import 'package:eterny_task/features/home/models/character.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/character_row.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/nemesis_table.dart';
import 'package:flutter/material.dart';

class CharacterRowWithChildren extends StatelessWidget {
  const CharacterRowWithChildren({
    required this.character,
    required this.expandedItems,
    required this.onToggleExpansion,
    super.key,
  });
  final Character character;
  final Set<String> expandedItems;
  final ValueChanged<String> onToggleExpansion;

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
        ),
        if (isExpanded && character.nemeses.isNotEmpty)
          NemesisTable(
            nemeses: character.nemeses,
            expandedItems: expandedItems,
            onToggleExpansion: onToggleExpansion,
          ),
      ],
    );
  }
}
