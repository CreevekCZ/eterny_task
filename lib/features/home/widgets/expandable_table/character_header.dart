import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/header_cell.dart';
import 'package:flutter/material.dart';

class CharacterHeader extends StatelessWidget {
  const CharacterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      ),
      child: const Row(
        children: [
          HeaderCell(column: ExpandableTableColumnConfig.expand),
          HeaderCell(column: ExpandableTableColumnConfig.id),
          HeaderCell(column: ExpandableTableColumnConfig.name),
          HeaderCell(column: ExpandableTableColumnConfig.gender),
          HeaderCell(column: ExpandableTableColumnConfig.ability),
          HeaderCell(column: ExpandableTableColumnConfig.minimalDistance),
          HeaderCell(column: ExpandableTableColumnConfig.weight),
          HeaderCell(column: ExpandableTableColumnConfig.born),
          HeaderCell(column: ExpandableTableColumnConfig.inSpaceSince),
          HeaderCell(column: ExpandableTableColumnConfig.beerConsumption),
          HeaderCell(column: ExpandableTableColumnConfig.knowsTheAnswer),
          HeaderCell(column: ExpandableTableColumnConfig.nemeses),
          HeaderCell(column: ExpandableTableColumnConfig.secrets),
          HeaderCell(column: ExpandableTableColumnConfig.delete),
        ],
      ),
    );
  }
}
