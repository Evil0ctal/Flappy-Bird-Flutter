// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'フラッピーバード';

  @override
  String get playerId => 'プレイヤー ID';

  @override
  String get enterNickname => 'ゲームのニックネームを入力';

  @override
  String get selectDifficulty => '難易度を選択';

  @override
  String get easy => '簡単';

  @override
  String get normal => '普通';

  @override
  String get hard => '難しい';

  @override
  String highScore(int score) {
    return 'ハイスコア: $score';
  }

  @override
  String get startGame => 'ゲーム開始';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get newRecord => '🎉 新記録！';

  @override
  String score(int score) {
    return 'スコア: $score';
  }

  @override
  String get tryAgain => 'もう一度';

  @override
  String get backToHome => 'ホームに戻る';

  @override
  String get playerIdRequired => 'プレイヤー ID を入力してください';

  @override
  String get aboutVersion => 'バージョン 1.0.0';

  @override
  String get aboutDescription =>
      'FlutterベースのFlappy Birdゲームデモで、Flameエンジンを使用したゲーム開発を紹介しています。';

  @override
  String get aboutPurpose => 'Flutterゲーム開発の学習とデモンストレーションのために作成されました。';

  @override
  String get aboutAuthor => '作者：Evil0ctal';

  @override
  String get aboutDate => '作成日：2025年5月27日';

  @override
  String get aboutOpenSource => 'GitHubで表示';

  @override
  String get close => '閉じる';

  @override
  String get settings => '設定';

  @override
  String get soundEffects => '効果音';

  @override
  String get soundEffectsDesc => 'ジャンプ、スコア、衝突音';

  @override
  String get backgroundMusic => 'BGM';

  @override
  String get backgroundMusicDesc => 'リラックスできるゲーム音楽';

  @override
  String get soundVolume => '効果音の音量';

  @override
  String get musicVolume => 'BGMの音量';

  @override
  String get linesOfCode => 'コード行数';

  @override
  String get supportedLanguages => '対応言語';

  @override
  String get funLevel => '楽しさレベル';

  @override
  String get aboutFlutterPowered => 'FlutterとFlameエンジンで動作';

  @override
  String get aboutGameDescription =>
      'モダンなFlutter技術で再構築されたクラシックFlappy Birdゲームを体験してください。スムーズなアニメーション、パーティクルエフェクト、複数の難易度、グローバルハイスコア記録機能を備えています。';

  @override
  String get developerName => 'Evil0ctal';

  @override
  String get developerTitle => 'Flutterゲーム開発者';

  @override
  String get developerMessage =>
      'プレイしていただきありがとうございます！このゲームはゲーム開発におけるFlutterの能力を示しています。ソースコードを探索して、あなた自身の素晴らしいゲームを作成してください！';

  @override
  String get viewSourceCode => 'ソースを見る';

  @override
  String get backToGame => 'ゲームに戻る';
}
