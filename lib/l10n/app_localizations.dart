import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Flappy Bird'**
  String get appTitle;

  /// Label for player ID input
  ///
  /// In en, this message translates to:
  /// **'Player ID'**
  String get playerId;

  /// Hint text for player ID input
  ///
  /// In en, this message translates to:
  /// **'Enter your game nickname'**
  String get enterNickname;

  /// Difficulty selection label
  ///
  /// In en, this message translates to:
  /// **'Select Difficulty'**
  String get selectDifficulty;

  /// Easy difficulty
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// Normal difficulty
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// Hard difficulty
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// High score display
  ///
  /// In en, this message translates to:
  /// **'High Score: {score}'**
  String highScore(int score);

  /// Start game button
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// Game over title
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// New high score message
  ///
  /// In en, this message translates to:
  /// **'🎉 New Record!'**
  String get newRecord;

  /// Score display
  ///
  /// In en, this message translates to:
  /// **'Score: {score}'**
  String score(int score);

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Return to home button
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Player ID required message
  ///
  /// In en, this message translates to:
  /// **'Please enter Player ID'**
  String get playerIdRequired;

  /// App version
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutVersion;

  /// About app description
  ///
  /// In en, this message translates to:
  /// **'A Flutter-based Flappy Bird game demonstration showcasing game development with the Flame engine.'**
  String get aboutDescription;

  /// App purpose description
  ///
  /// In en, this message translates to:
  /// **'Created for learning and demonstration purposes of Flutter game development.'**
  String get aboutPurpose;

  /// Author information
  ///
  /// In en, this message translates to:
  /// **'Author: Evil0ctal'**
  String get aboutAuthor;

  /// Creation date
  ///
  /// In en, this message translates to:
  /// **'Created: May 27, 2025'**
  String get aboutDate;

  /// Open source link text
  ///
  /// In en, this message translates to:
  /// **'View on GitHub'**
  String get aboutOpenSource;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Sound effects toggle
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// Sound effects description
  ///
  /// In en, this message translates to:
  /// **'Jump, score, and collision sounds'**
  String get soundEffectsDesc;

  /// Background music toggle
  ///
  /// In en, this message translates to:
  /// **'Background Music'**
  String get backgroundMusic;

  /// Background music description
  ///
  /// In en, this message translates to:
  /// **'Relaxing game music'**
  String get backgroundMusicDesc;

  /// Sound volume label
  ///
  /// In en, this message translates to:
  /// **'Sound Volume'**
  String get soundVolume;

  /// Music volume label
  ///
  /// In en, this message translates to:
  /// **'Music Volume'**
  String get musicVolume;

  /// Lines of code stat
  ///
  /// In en, this message translates to:
  /// **'Lines of Code'**
  String get linesOfCode;

  /// Supported languages stat
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get supportedLanguages;

  /// Fun level stat
  ///
  /// In en, this message translates to:
  /// **'Fun Level'**
  String get funLevel;

  /// Flutter powered message
  ///
  /// In en, this message translates to:
  /// **'Powered by Flutter & Flame Engine'**
  String get aboutFlutterPowered;

  /// Game description
  ///
  /// In en, this message translates to:
  /// **'Experience the classic Flappy Bird gameplay reimagined with modern Flutter technology. Features smooth animations, particle effects, multiple difficulty levels, and global high score tracking.'**
  String get aboutGameDescription;

  /// Developer name
  ///
  /// In en, this message translates to:
  /// **'Evil0ctal'**
  String get developerName;

  /// Developer title
  ///
  /// In en, this message translates to:
  /// **'Flutter Game Developer'**
  String get developerTitle;

  /// Developer message
  ///
  /// In en, this message translates to:
  /// **'Thanks for playing! This game showcases Flutter\'s capabilities for game development. Feel free to explore the source code and create your own amazing games!'**
  String get developerMessage;

  /// View source code button
  ///
  /// In en, this message translates to:
  /// **'View Source'**
  String get viewSourceCode;

  /// Back to game button
  ///
  /// In en, this message translates to:
  /// **'Back to Game'**
  String get backToGame;
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
      <String>['en', 'es', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
