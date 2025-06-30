import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackBarType type = AppSnackBarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final backgroundColor = type.backgroundColor(colorScheme);
    final textColor = type.textColor(colorScheme);
    final iconColor = type.iconColor(colorScheme);
    final icon = type.icon;

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      duration: duration,
      elevation: 6,
      action: actionLabel != null && onAction != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onAction,
              textColor: iconColor,
              backgroundColor: iconColor.withValues(alpha: 0.1),
            )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: AppSnackBarType.success,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 5),
  }) {
    show(
      context,
      message: message,
      type: AppSnackBarType.error,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: AppSnackBarType.warning,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: AppSnackBarType.info,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }
}

enum AppSnackBarType {
  success,
  error,
  warning,
  info;

  Color backgroundColor(ColorScheme colorScheme) => switch (this) {
    AppSnackBarType.success => colorScheme.primaryContainer,
    AppSnackBarType.error => colorScheme.errorContainer,
    AppSnackBarType.warning => colorScheme.tertiaryContainer,
    AppSnackBarType.info => colorScheme.surfaceContainerHigh,
  };

  Color textColor(ColorScheme colorScheme) => switch (this) {
    AppSnackBarType.success => colorScheme.onPrimaryContainer,
    AppSnackBarType.error => colorScheme.onErrorContainer,
    AppSnackBarType.warning => colorScheme.onTertiaryContainer,
    AppSnackBarType.info => colorScheme.onSurface,
  };

  Color iconColor(ColorScheme colorScheme) => switch (this) {
    AppSnackBarType.success => colorScheme.primary,
    AppSnackBarType.error => colorScheme.error,
    AppSnackBarType.warning => colorScheme.tertiary,
    AppSnackBarType.info => colorScheme.primary,
  };

  IconData get icon => switch (this) {
    AppSnackBarType.success => Icons.check_circle_rounded,
    AppSnackBarType.error => Icons.error_rounded,
    AppSnackBarType.warning => Icons.warning_rounded,
    AppSnackBarType.info => Icons.info_rounded,
  };
}
