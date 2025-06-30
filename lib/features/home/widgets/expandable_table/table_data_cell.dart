import 'package:flutter/material.dart';

class TableDataCell extends StatelessWidget {
  const TableDataCell({
    required this.child,
    required this.width,
    super.key,
  });
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: child,
    );
  }
}
