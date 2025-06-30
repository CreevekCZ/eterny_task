import 'package:eterny_task/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension L10nExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
