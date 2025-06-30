import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @charactersTable__lblTitle.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get charactersTable__lblTitle;

  /// No description provided for @charactersTable__lblId.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get charactersTable__lblId;

  /// No description provided for @charactersTable__lblName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get charactersTable__lblName;

  /// No description provided for @charactersTable__lblGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get charactersTable__lblGender;

  /// No description provided for @charactersTable__lblAbility.
  ///
  /// In en, this message translates to:
  /// **'Ability'**
  String get charactersTable__lblAbility;

  /// No description provided for @charactersTable__lblMinimalDistance.
  ///
  /// In en, this message translates to:
  /// **'Minimal Distance'**
  String get charactersTable__lblMinimalDistance;

  /// No description provided for @charactersTable__lblWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get charactersTable__lblWeight;

  /// No description provided for @charactersTable__lblBorn.
  ///
  /// In en, this message translates to:
  /// **'Born'**
  String get charactersTable__lblBorn;

  /// No description provided for @charactersTable__lblInSpaceSince.
  ///
  /// In en, this message translates to:
  /// **'In Space Since'**
  String get charactersTable__lblInSpaceSince;

  /// No description provided for @charactersTable__lblBeerConsumption.
  ///
  /// In en, this message translates to:
  /// **'Beer Consumption (l/y)'**
  String get charactersTable__lblBeerConsumption;

  /// No description provided for @charactersTable__lblKnowsTheAnswer.
  ///
  /// In en, this message translates to:
  /// **'Knows The Answer'**
  String get charactersTable__lblKnowsTheAnswer;

  /// No description provided for @charactersTable__lblNemeses.
  ///
  /// In en, this message translates to:
  /// **'Nemeses'**
  String get charactersTable__lblNemeses;

  /// No description provided for @charactersTable__lblSecrets.
  ///
  /// In en, this message translates to:
  /// **'Secrets'**
  String get charactersTable__lblSecrets;

  /// No description provided for @charactersTable__lblNemesisId.
  ///
  /// In en, this message translates to:
  /// **'Nemesis ID'**
  String get charactersTable__lblNemesisId;

  /// No description provided for @charactersTable__lblCharacterId.
  ///
  /// In en, this message translates to:
  /// **'Character ID'**
  String get charactersTable__lblCharacterId;

  /// No description provided for @charactersTable__lblIsAlive.
  ///
  /// In en, this message translates to:
  /// **'Is Alive'**
  String get charactersTable__lblIsAlive;

  /// No description provided for @charactersTable__lblYears.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get charactersTable__lblYears;

  /// No description provided for @charactersTable__lblSecretId.
  ///
  /// In en, this message translates to:
  /// **'Secret ID'**
  String get charactersTable__lblSecretId;

  /// No description provided for @charactersTable__lblSecreteCode.
  ///
  /// In en, this message translates to:
  /// **'Secrete Code'**
  String get charactersTable__lblSecreteCode;

  /// No description provided for @charactersTable__lblCharacter.
  ///
  /// In en, this message translates to:
  /// **'Character'**
  String get charactersTable__lblCharacter;

  /// No description provided for @charactersTable__lblNemesis.
  ///
  /// In en, this message translates to:
  /// **'Nemesis'**
  String get charactersTable__lblNemesis;

  /// No description provided for @charactersTable__lblDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get charactersTable__lblDelete;

  /// No description provided for @charactersTable__lblNoCharacters.
  ///
  /// In en, this message translates to:
  /// **'No characters found'**
  String get charactersTable__lblNoCharacters;

  /// No description provided for @charactersTable__lblTapToReloadCharacters.
  ///
  /// In en, this message translates to:
  /// **'Tap the button below to reload characters'**
  String get charactersTable__lblTapToReloadCharacters;

  /// No description provided for @charactersTable__btnReloadCharacters.
  ///
  /// In en, this message translates to:
  /// **'Reload Characters'**
  String get charactersTable__btnReloadCharacters;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
