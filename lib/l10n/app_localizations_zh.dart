// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '飞翔的小鸟';

  @override
  String get playerId => '玩家 ID';

  @override
  String get enterNickname => '输入你的游戏昵称';

  @override
  String get selectDifficulty => '选择难度';

  @override
  String get easy => '简单';

  @override
  String get normal => '普通';

  @override
  String get hard => '困难';

  @override
  String highScore(int score) {
    return '最高分: $score';
  }

  @override
  String get startGame => '开始游戏';

  @override
  String get gameOver => '游戏结束';

  @override
  String get newRecord => '🎉 新纪录！';

  @override
  String score(int score) {
    return '得分: $score';
  }

  @override
  String get tryAgain => '重新开始';

  @override
  String get backToHome => '返回主页';

  @override
  String get playerIdRequired => '请输入玩家 ID';

  @override
  String get aboutVersion => '版本 1.0.0';

  @override
  String get aboutDescription =>
      '一个基于Flutter的Flappy Bird游戏演示，展示了使用Flame引擎进行游戏开发。';

  @override
  String get aboutPurpose => '本应用作为Flutter游戏开发的学习和演示用途而创建。';

  @override
  String get aboutAuthor => '作者：Evil0ctal';

  @override
  String get aboutDate => '创建时间：2025年5月27日';

  @override
  String get aboutOpenSource => '在GitHub上查看';

  @override
  String get close => '关闭';

  @override
  String get settings => '设置';

  @override
  String get soundEffects => '音效';

  @override
  String get soundEffectsDesc => '跳跃、得分和碰撞音效';

  @override
  String get backgroundMusic => '背景音乐';

  @override
  String get backgroundMusicDesc => '放松的游戏音乐';

  @override
  String get soundVolume => '音效音量';

  @override
  String get musicVolume => '音乐音量';

  @override
  String get linesOfCode => '代码行数';

  @override
  String get supportedLanguages => '支持语言';

  @override
  String get funLevel => '趣味程度';

  @override
  String get aboutFlutterPowered => '由 Flutter 和 Flame 引擎驱动';

  @override
  String get aboutGameDescription =>
      '体验用现代Flutter技术重新构想的经典Flappy Bird游戏。具有流畅的动画、粒子效果、多种难度级别和全球高分记录。';

  @override
  String get developerName => 'Evil0ctal';

  @override
  String get developerTitle => 'Flutter 游戏开发者';

  @override
  String get developerMessage =>
      '感谢游玩！这个游戏展示了Flutter在游戏开发方面的能力。欢迎探索源代码并创建您自己的精彩游戏！';

  @override
  String get viewSourceCode => '查看源代码';

  @override
  String get backToGame => '返回游戏';
}
