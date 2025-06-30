import 'package:eterny_task/core/extensions/tz_date_time_extension.dart';
import 'package:eterny_task/features/home/models/character.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/table_data_cell.dart';
import 'package:eterny_task/ui/count_badge.dart';
import 'package:flutter/material.dart';

class CharacterRow extends StatefulWidget {
  const CharacterRow({
    required this.character,
    required this.onToggleExpansion,
    this.isExpanded = false,
    super.key,
  });

  final Character character;
  final bool isExpanded;
  final ValueChanged<String> onToggleExpansion;

  @override
  State<CharacterRow> createState() => _CharacterRowState();
}

class _CharacterRowState extends State<CharacterRow> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => widget.onToggleExpansion('character_${widget.character.uuid}'),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
        ),
        child: Row(
          children: [
            TableDataCell(
              width: ExpandableTableColumnConfig.expand.width,
              child: widget.character.canExpand
                  ? Icon(
                      widget.isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: widget.character.nemeses.isNotEmpty
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    )
                  : const SizedBox(height: 24),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.id.width,
              child: Text(
                '${widget.character.id}',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.name.width,
              child: Text(
                widget.character.name,
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.gender.width,
              child: Text(
                widget.character.gender ?? '-',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.ability.width,
              child: Text(
                widget.character.ability ?? '-',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.minimalDistance.width,
              child: Text(
                widget.character.minimalDistance,
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.weight.width,
              child: Text(
                '${widget.character.weight}',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.born.width,
              child: Text(
                widget.character.born.toProprietaryDateFormat,
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.inSpaceSince.width,
              child: Text(
                widget.character.inSpaceSince.toProprietaryDateFormat,
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.beerConsumption.width,
              child: Text(
                '${widget.character.beerConsumption}',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.knowsTheAnswer.width,
              child: Icon(
                widget.character.knowsTheAnswer ? Icons.check : Icons.close,
                color: widget.character.knowsTheAnswer
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
                size: 16,
              ),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.nemeses.width,
              child: widget.character.nemeses.isNotEmpty
                  ? CountBadge(
                      count: widget.character.numberOfNemeses,
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      textColor: Colors.white,
                    )
                  : Text('0', style: TextStyle(color: theme.colorScheme.onSurface)),
            ),
            TableDataCell(
              width: ExpandableTableColumnConfig.secrets.width,
              child: widget.character.nemeses.isNotEmpty
                  ? CountBadge(
                      count: widget.character.numberOfSecrets,
                      backgroundColor: theme.colorScheme.tertiaryContainer,
                      textColor: theme.colorScheme.onTertiaryContainer,
                    )
                  : Text('0', style: TextStyle(color: theme.colorScheme.onSurface)),
            ),
          ],
        ),
      ),
    );
  }
}
