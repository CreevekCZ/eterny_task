import 'package:eterny_task/features/home/models/nemesis.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/nemesis_header.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/nemesis_row_with_children.dart';
import 'package:flutter/material.dart';

class NemesisTable extends StatelessWidget {
  const NemesisTable({
    required this.nemeses,
    required this.expandedItems,
    required this.onToggleExpansion,
    this.onDeleteNemesis,
    this.onDeleteSecret,
    super.key,
  });

  final List<Nemesis> nemeses;
  final Set<String> expandedItems;
  final ValueChanged<String> onToggleExpansion;

  final ValueChanged<int>? onDeleteNemesis;
  final OnDeleteSecretFromNemesis? onDeleteSecret;

  void _onDeleteSecret(int nemesisId, int secretId) {
    onDeleteSecret?.call(nemesisId, secretId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 8, bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          const NemesisHeader(),
          ...nemeses.map(
            (nemesis) => NemesisRowWithChildren(
              nemesis: nemesis,
              expandedItems: expandedItems,
              onToggleExpansion: onToggleExpansion,
              onDeleteNemesis: onDeleteNemesis,
              onDeleteSecret: _onDeleteSecret,
            ),
          ),
        ],
      ),
    );
  }
}
