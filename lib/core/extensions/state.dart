import 'package:auto_route/auto_route.dart';
import 'package:eterny_task/core/extensions/l10n.dart';
import 'package:eterny_task/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension StateX on State {
  AppLocalizations get l10n => context.l10n;
  StackRouter get router => context.router;
}
