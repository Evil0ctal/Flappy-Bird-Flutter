// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flappy Bird';

  @override
  String get playerId => 'Player ID';

  @override
  String get enterNickname => 'Enter your game nickname';

  @override
  String get selectDifficulty => 'Select Difficulty';

  @override
  String get easy => 'Easy';

  @override
  String get normal => 'Normal';

  @override
  String get hard => 'Hard';

  @override
  String highScore(int score) {
    return 'High Score: $score';
  }

  @override
  String get startGame => 'Start Game';

  @override
  String get gameOver => 'Game Over';

  @override
  String get newRecord => '🎉 New Record!';

  @override
  String score(int score) {
    return 'Score: $score';
  }

  @override
  String get tryAgain => 'Try Again';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get playerIdRequired => 'Please enter Player ID';

  @override
  String get aboutVersion => 'Version 1.0.0';

  @override
  String get aboutDescription =>
      'A Flutter-based Flappy Bird game demonstration showcasing game development with the Flame engine.';

  @override
  String get aboutPurpose =>
      'Created for learning and demonstration purposes of Flutter game development.';

  @override
  String get aboutAuthor => 'Author: Evil0ctal';

  @override
  String get aboutDate => 'Created: May 27, 2025';

  @override
  String get aboutOpenSource => 'View on GitHub';

  @override
  String get close => 'Close';

  @override
  String get settings => 'Settings';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get soundEffectsDesc => 'Jump, score, and collision sounds';

  @override
  String get backgroundMusic => 'Background Music';

  @override
  String get backgroundMusicDesc => 'Relaxing game music';

  @override
  String get soundVolume => 'Sound Volume';

  @override
  String get musicVolume => 'Music Volume';

  @override
  String get linesOfCode => 'Lines of Code';

  @override
  String get supportedLanguages => 'Languages';

  @override
  String get funLevel => 'Fun Level';

  @override
  String get aboutFlutterPowered => 'Powered by Flutter & Flame Engine';

  @override
  String get aboutGameDescription =>
      'Experience the classic Flappy Bird gameplay reimagined with modern Flutter technology. Features smooth animations, particle effects, multiple difficulty levels, and global high score tracking.';

  @override
  String get developerName => 'Evil0ctal';

  @override
  String get developerTitle => 'Flutter Game Developer';

  @override
  String get developerMessage =>
      'Thanks for playing! This game showcases Flutter\'s capabilities for game development. Feel free to explore the source code and create your own amazing games!';

  @override
  String get viewSourceCode => 'View Source';

  @override
  String get backToGame => 'Back to Game';
}
