import 'package:eterny_task/features/home/models/nemesis.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/table_data_cell.dart';
import 'package:eterny_task/ui/count_badge.dart';
import 'package:flutter/material.dart';

class NemesisRow extends StatelessWidget {
  const NemesisRow({
    required this.nemesis,
    required this.isExpanded,
    required this.onToggleExpansion,
    this.onDeleteNemesis,
    super.key,
  });
  final Nemesis nemesis;
  final bool isExpanded;
  final ValueChanged<String> onToggleExpansion;

  final ValueChanged<int>? onDeleteNemesis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onToggleExpansion('nemesis_${nemesis.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.secondary.withValues(alpha: 0.5)),
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: theme.colorScheme.onSecondaryContainer),
          child: Row(
            children: [
              TableDataCell(
                width: ExpandableTableColumnConfig.expand.width,
                child: Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: nemesis.secrets.isNotEmpty
                      ? theme.colorScheme.secondary
                      : theme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
              ),
              TableDataCell(
                width: ExpandableTableColumnConfig.nemesisId.width,
                child: Text(
                  '${nemesis.id}',
                ),
              ),
              TableDataCell(
                width: ExpandableTableColumnConfig.characterId.width,
                child: Text(
                  '${nemesis.characterId}',
                ),
              ),
              TableDataCell(
                width: ExpandableTableColumnConfig.isAlive.width,
                child: Icon(
                  nemesis.isAlive ? Icons.check : Icons.close,
                  color: nemesis.isAlive ? theme.colorScheme.primary : theme.colorScheme.error,
                  size: 14,
                ),
              ),
              TableDataCell(
                width: ExpandableTableColumnConfig.years.width,
                child: Text(
                  nemesis.years ?? '',
                ),
              ),
              TableDataCell(
                width: ExpandableTableColumnConfig.secrets.width,
                child: nemesis.secrets.isNotEmpty
                    ? CountBadge(
                        count: nemesis.secrets.length,
                        backgroundColor: theme.colorScheme.tertiaryContainer,
                        textColor: theme.colorScheme.onTertiaryContainer,
                      )
                    : const Text('0'),
              ),
              TableDataCell(
                width: ExpandableTableColumnConfig.delete.width,
                child: onDeleteNemesis != null
                    ? IconButton(
                        onPressed: () => onDeleteNemesis?.call(nemesis.id),
                        icon: const Icon(Icons.delete, size: 24),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
