import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _bgmPlayer = AudioPlayer();
  
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  double _sfxVolume = 0.7;
  double _musicVolume = 0.3;

  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  double get sfxVolume => _sfxVolume;
  double get musicVolume => _musicVolume;

  Future<void> init() async {
    await _sfxPlayer.setReleaseMode(ReleaseMode.stop);
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    
    await _sfxPlayer.setVolume(_sfxVolume);
    await _bgmPlayer.setVolume(_musicVolume);
  }

  Future<void> playJump() async {
    if (!_soundEnabled) return;
    try {
      await _sfxPlayer.play(AssetSource('sounds/jump.wav'));
    } catch (e) {
      debugPrint('Error playing jump sound: $e');
    }
  }

  Future<void> playScore() async {
    if (!_soundEnabled) return;
    try {
      await _sfxPlayer.play(AssetSource('sounds/score.wav'));
    } catch (e) {
      debugPrint('Error playing score sound: $e');
    }
  }

  Future<void> playHit() async {
    if (!_soundEnabled) return;
    try {
      await _sfxPlayer.play(AssetSource('sounds/hit.wav'));
    } catch (e) {
      debugPrint('Error playing hit sound: $e');
    }
  }

  Future<void> playGameOver() async {
    if (!_soundEnabled) return;
    try {
      await _sfxPlayer.play(AssetSource('sounds/game_over.wav'));
    } catch (e) {
      debugPrint('Error playing game over sound: $e');
    }
  }

  Future<void> startBackgroundMusic() async {
    if (!_musicEnabled) return;
    try {
      // Pre-load the audio to avoid gaps
      await _bgmPlayer.setSource(AssetSource('sounds/background_music.mp3'));
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.resume();
    } catch (e) {
      debugPrint('Error playing background music: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    await _bgmPlayer.stop();
  }

  Future<void> pauseBackgroundMusic() async {
    await _bgmPlayer.pause();
  }

  Future<void> resumeBackgroundMusic() async {
    if (!_musicEnabled) return;
    await _bgmPlayer.resume();
  }

  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
    if (!enabled) {
      _sfxPlayer.stop();
    }
  }

  void setMusicEnabled(bool enabled) {
    _musicEnabled = enabled;
    if (enabled) {
      startBackgroundMusic();
    } else {
      stopBackgroundMusic();
    }
  }

  void setSfxVolume(double volume) {
    _sfxVolume = volume.clamp(0.0, 1.0);
    _sfxPlayer.setVolume(_sfxVolume);
  }

  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    _bgmPlayer.setVolume(_musicVolume);
  }

  void dispose() {
    _sfxPlayer.dispose();
    _bgmPlayer.dispose();
  }
}