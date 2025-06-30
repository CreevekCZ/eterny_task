import 'package:eterny_task/features/home/models/nemesis.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/nemesis_row.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/secret_table.dart';
import 'package:flutter/material.dart';

class NemesisRowWithChildren extends StatelessWidget {
  const NemesisRowWithChildren({
    required this.nemesis,
    required this.expandedItems,
    required this.onToggleExpansion,
    super.key,
  });

  final Nemesis nemesis;
  final Set<String> expandedItems;
  final ValueChanged<String> onToggleExpansion;

  @override
  Widget build(BuildContext context) {
    final isExpanded = expandedItems.contains('nemesis_${nemesis.id}');

    return Column(
      children: [
        NemesisRow(
          nemesis: nemesis,
          isExpanded: isExpanded,
          onToggleExpansion: onToggleExpansion,
        ),
        if (isExpanded && nemesis.secrets.isNotEmpty) SecretTable(secrets: nemesis.secrets),
      ],
    );
  }
}
