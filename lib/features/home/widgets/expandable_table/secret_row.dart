import 'package:eterny_task/features/home/models/secret.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/table_data_cell.dart';
import 'package:flutter/material.dart';

class SecretRow extends StatelessWidget {
  const SecretRow({
    required this.secret,
    super.key,
  });
  final Secret secret;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5),
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.tertiary.withValues(alpha: 0.5)),
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
        child: Row(
          children: [
            TableDataCell(
              width: ExpandableTableColumnConfig.secretId.width,
              child: Text(
                '${secret.id}',
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.nemesisId.width,
              child: Text(
                '${secret.nemesisId}',
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.secreteCode.width,
              child: Text(
                secret.secreteCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
