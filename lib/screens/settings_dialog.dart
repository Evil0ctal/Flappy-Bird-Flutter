import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late AudioService _audioService;
  late StorageService _storageService;
  
  @override
  void initState() {
    super.initState();
    _audioService = AudioService();
    _storageService = context.read<StorageService>();
    
    // Load saved settings
    _loadSettings();
  }
  
  void _loadSettings() async {
    final prefs = await _storageService.prefs;
    setState(() {
      _audioService.setSoundEnabled(prefs.getBool('soundEnabled') ?? true);
      _audioService.setMusicEnabled(prefs.getBool('musicEnabled') ?? true);
      _audioService.setSfxVolume(prefs.getDouble('sfxVolume') ?? 0.7);
      _audioService.setMusicVolume(prefs.getDouble('musicVolume') ?? 0.3);
    });
  }
  
  void _saveSettings() async {
    final prefs = await _storageService.prefs;
    await prefs.setBool('soundEnabled', _audioService.soundEnabled);
    await prefs.setBool('musicEnabled', _audioService.musicEnabled);
    await prefs.setDouble('sfxVolume', _audioService.sfxVolume);
    await prefs.setDouble('musicVolume', _audioService.musicVolume);
  }
  
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings, size: 32, color: Colors.blue),
                const SizedBox(width: 12),
                Text(
                  localizations.settings,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Sound Effects Toggle
            SwitchListTile(
              title: Text(localizations.soundEffects),
              subtitle: Text(localizations.soundEffectsDesc),
              value: _audioService.soundEnabled,
              onChanged: (value) {
                setState(() {
                  _audioService.setSoundEnabled(value);
                  _saveSettings();
                });
              },
              secondary: const Icon(Icons.volume_up),
            ),
            
            // Sound Effects Volume
            if (_audioService.soundEnabled) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.soundVolume,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Slider(
                      value: _audioService.sfxVolume,
                      onChanged: (value) {
                        setState(() {
                          _audioService.setSfxVolume(value);
                          _saveSettings();
                        });
                      },
                      onChangeEnd: (value) {
                        // Play a test sound
                        _audioService.playJump();
                      },
                    ),
                  ],
                ),
              ),
            ],
            
            const Divider(height: 24),
            
            // Background Music Toggle
            SwitchListTile(
              title: Text(localizations.backgroundMusic),
              subtitle: Text(localizations.backgroundMusicDesc),
              value: _audioService.musicEnabled,
              onChanged: (value) {
                setState(() {
                  _audioService.setMusicEnabled(value);
                  _saveSettings();
                });
              },
              secondary: const Icon(Icons.music_note),
            ),
            
            // Music Volume
            if (_audioService.musicEnabled) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.musicVolume,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Slider(
                      value: _audioService.musicVolume,
                      onChanged: (value) {
                        setState(() {
                          _audioService.setMusicVolume(value);
                          _saveSettings();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Close button
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(localizations.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}