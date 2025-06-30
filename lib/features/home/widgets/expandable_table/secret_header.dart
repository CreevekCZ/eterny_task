import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/header_cell.dart';
import 'package:flutter/material.dart';

class SecretHeader extends StatelessWidget {
  const SecretHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        border: Border(bottom: BorderSide(color: theme.colorScheme.tertiary)),
      ),
      child: const Row(
        children: [
          HeaderCell(column: ExpandableTableColumnConfig.secretId),
          HeaderCell(column: ExpandableTableColumnConfig.nemesisId),
          HeaderCell(column: ExpandableTableColumnConfig.secreteCode),
        ],
      ),
    );
  }
}
