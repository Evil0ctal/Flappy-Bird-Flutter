import 'package:shared_preferences/shared_preferences.dart';

enum Difficulty { easy, normal, hard }

class StorageService {
  late SharedPreferences _prefs;
  
  static const String _playerIdKey = 'player_id';
  static const String _highScoreEasyKey = 'high_score_easy';
  static const String _highScoreNormalKey = 'high_score_normal';
  static const String _highScoreHardKey = 'high_score_hard';
  
  // Getter for prefs to allow settings access
  Future<SharedPreferences> get prefs async => _prefs;
  
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  String? get playerId => _prefs.getString(_playerIdKey);
  
  Future<void> setPlayerId(String id) async {
    await _prefs.setString(_playerIdKey, id);
  }
  
  int getHighScore(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return _prefs.getInt(_highScoreEasyKey) ?? 0;
      case Difficulty.normal:
        return _prefs.getInt(_highScoreNormalKey) ?? 0;
      case Difficulty.hard:
        return _prefs.getInt(_highScoreHardKey) ?? 0;
    }
  }
  
  Future<void> setHighScore(Difficulty difficulty, int score) async {
    switch (difficulty) {
      case Difficulty.easy:
        await _prefs.setInt(_highScoreEasyKey, score);
        break;
      case Difficulty.normal:
        await _prefs.setInt(_highScoreNormalKey, score);
        break;
      case Difficulty.hard:
        await _prefs.setInt(_highScoreHardKey, score);
        break;
    }
  }
  
  Future<bool> updateHighScoreIfNeeded(Difficulty difficulty, int newScore) async {
    final currentHighScore = getHighScore(difficulty);
    if (newScore > currentHighScore) {
      await setHighScore(difficulty, newScore);
      return true;
    }
    return false;
  }
}