import 'package:eterny_task/features/home/models/secret.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/secret_header.dart';
import 'package:eterny_task/features/home/widgets/expandable_table/secret_row.dart';
import 'package:flutter/material.dart';

class SecretTable extends StatelessWidget {
  const SecretTable({
    required this.secrets,
    this.onDeleteSecret,
    super.key,
  });
  final List<Secret> secrets;
  final ValueChanged<int>? onDeleteSecret;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 8, bottom: 4),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.tertiary),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          const SecretHeader(),
          ...secrets.map(
            (secret) => SecretRow(
              secret: secret,
              onDeleteSecret: onDeleteSecret,
            ),
          ),
        ],
      ),
    );
  }
}
