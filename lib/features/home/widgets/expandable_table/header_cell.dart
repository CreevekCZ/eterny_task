import 'package:eterny_task/features/home/widgets/expandable_table/expandable_table.dart';
import 'package:eterny_task/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HeaderCell extends StatelessWidget {
  const HeaderCell({
    required this.column,
    super.key,
  });
  final ExpandableTableColumnConfig column;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: column.width,
      padding: const EdgeInsets.all(12),
      child: Text(
        column.getLocalizedName(AppLocalizations.of(context)!),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: theme.colorScheme.onPrimaryContainer,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
