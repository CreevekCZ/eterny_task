import 'package:eterny_task/features/home/models/nemesis.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/nemesis_row.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/secret_table.dart';
import 'package:flutter/material.dart';

typedef OnDeleteSecretFromNemesis = Function(int nemesisId, int secretId);

class NemesisRowWithChildren extends StatelessWidget {
  const NemesisRowWithChildren({
    required this.nemesis,
    required this.expandedItems,
    required this.onToggleExpansion,
    this.onDeleteNemesis,
    this.onDeleteSecret,
    super.key,
  });

  final Nemesis nemesis;
  final Set<String> expandedItems;
  final ValueChanged<String> onToggleExpansion;

  final ValueChanged<int>? onDeleteNemesis;
  final OnDeleteSecretFromNemesis? onDeleteSecret;

  void _onDeleteSecret(int secretId) {
    onDeleteSecret?.call(nemesis.id, secretId);
  }

  @override
  Widget build(BuildContext context) {
    final isExpanded = expandedItems.contains('nemesis_${nemesis.id}');

    return Column(
      children: [
        NemesisRow(
          nemesis: nemesis,
          isExpanded: isExpanded,
          onToggleExpansion: onToggleExpansion,
          onDeleteNemesis: onDeleteNemesis,
        ),
        if (isExpanded && nemesis.secrets.isNotEmpty)
          SecretTable(
            secrets: nemesis.secrets,
            onDeleteSecret: _onDeleteSecret,
          ),
      ],
    );
  }
}
