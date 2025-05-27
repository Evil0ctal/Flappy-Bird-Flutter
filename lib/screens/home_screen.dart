import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../services/audio_service.dart';
import 'countdown_screen.dart';
import 'about_dialog.dart' as about;
import 'settings_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _playerIdController = TextEditingController();
  Difficulty _selectedDifficulty = Difficulty.normal;
  late StorageService _storageService;
  
  @override
  void initState() {
    super.initState();
    _storageService = context.read<StorageService>();
    _playerIdController.text = _storageService.playerId ?? '';
    _initAudio();
  }
  
  void _initAudio() async {
    final audioService = AudioService();
    await audioService.init();
    // Load saved settings
    final prefs = await _storageService.prefs;
    final musicEnabled = prefs.getBool('musicEnabled') ?? true;
    if (musicEnabled) {
      await audioService.startBackgroundMusic();
    }
  }
  
  @override
  void dispose() {
    _playerIdController.dispose();
    super.dispose();
  }
  
  void _startGame() async {
    final playerId = _playerIdController.text.trim();
    if (playerId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.playerIdRequired)),
      );
      return;
    }
    
    await _storageService.setPlayerId(playerId);
    
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountdownScreen(difficulty: _selectedDifficulty),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.lightBlueAccent],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.flutter_dash,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _playerIdController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.playerId,
                            hintText: AppLocalizations.of(context)!.enterNickname,
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          AppLocalizations.of(context)!.selectDifficulty,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SegmentedButton<Difficulty>(
                          segments: [
                            ButtonSegment(
                              value: Difficulty.easy,
                              label: Text(AppLocalizations.of(context)!.easy),
                              icon: const Icon(Icons.sentiment_satisfied),
                            ),
                            ButtonSegment(
                              value: Difficulty.normal,
                              label: Text(AppLocalizations.of(context)!.normal),
                              icon: const Icon(Icons.sentiment_neutral),
                            ),
                            ButtonSegment(
                              value: Difficulty.hard,
                              label: Text(AppLocalizations.of(context)!.hard),
                              icon: const Icon(Icons.sentiment_very_dissatisfied),
                            ),
                          ],
                          selected: {_selectedDifficulty},
                          onSelectionChanged: (Set<Difficulty> newSelection) {
                            setState(() {
                              _selectedDifficulty = newSelection.first;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.highScore(_storageService.getHighScore(_selectedDifficulty)),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _startGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.startGame,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const SettingsDialog(),
                          );
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white70,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const about.AboutDialog(),
                          );
                        },
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.white70,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}