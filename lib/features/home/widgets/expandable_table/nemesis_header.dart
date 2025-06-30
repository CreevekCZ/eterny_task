import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/header_cell.dart';
import 'package:flutter/material.dart';

class NemesisHeader extends StatelessWidget {
  const NemesisHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        border: Border(bottom: BorderSide(color: theme.colorScheme.secondary)),
      ),
      child: const Row(
        children: [
          HeaderCell(column: ExpandableTableColumnConfig.expand),
          HeaderCell(column: ExpandableTableColumnConfig.nemesisId),
          HeaderCell(column: ExpandableTableColumnConfig.characterId),
          HeaderCell(column: ExpandableTableColumnConfig.isAlive),
          HeaderCell(column: ExpandableTableColumnConfig.years),
          HeaderCell(column: ExpandableTableColumnConfig.secrets),
        ],
      ),
    );
  }
}
