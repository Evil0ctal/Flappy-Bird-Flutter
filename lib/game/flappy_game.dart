import 'package:flame/game.dart';
import 'package:flame/events.dart';
import '../services/storage_service.dart';
import '../services/audio_service.dart';
import 'bird.dart';
import 'pipe.dart';
import 'background.dart';
import 'score_text.dart';
import 'particle_system.dart';

class FlappyGame extends FlameGame with TapDetector, HasCollisionDetection {
  final Difficulty difficulty;
  late Bird bird;
  late ScoreText scoreText;
  late Background background;
  late AudioService audioService;
  late ParticleManager particleManager;
  
  int score = 0;
  bool isGameOver = false;
  double pipeSpawnTimer = 0;
  double pipeSpawnInterval = 2.0;
  
  double get gravity {
    switch (difficulty) {
      case Difficulty.easy:
        return 980;
      case Difficulty.normal:
        return 1200;
      case Difficulty.hard:
        return 1500;
    }
  }
  
  double get pipeGapSize {
    switch (difficulty) {
      case Difficulty.easy:
        return 200;
      case Difficulty.normal:
        return 160;
      case Difficulty.hard:
        return 120;
    }
  }
  
  double get pipeHorizontalGap {
    switch (difficulty) {
      case Difficulty.easy:
        return 300;
      case Difficulty.normal:
        return 250;
      case Difficulty.hard:
        return 200;
    }
  }
  
  FlappyGame({required this.difficulty});
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    camera.viewfinder.visibleGameSize = size;
    
    audioService = AudioService();
    await audioService.init();
    await audioService.startBackgroundMusic();
    
    particleManager = ParticleManager();
    
    background = Background();
    await add(background);
    
    bird = Bird(game: this);
    await add(bird);
    
    scoreText = ScoreText();
    await add(scoreText);
    
    pipeSpawnInterval = pipeHorizontalGap / 150;
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (!isGameOver) {
      pipeSpawnTimer += dt;
      if (pipeSpawnTimer >= pipeSpawnInterval) {
        spawnPipe();
        pipeSpawnTimer = 0;
      }
      
      final pipeGroups = children.whereType<PipeGroup>().toList();
      
      for (final pipeGroup in pipeGroups) {
        // 检查小鸟是否通过了管道中心（管道左边缘 + 管道宽度一半）
        if (!pipeGroup.scored && pipeGroup.position.x + 40 < bird.position.x) {
          pipeGroup.scored = true;
          incrementScore();
        }
        
        // 移除超出屏幕的管道
        if (pipeGroup.position.x < -100) {
          pipeGroup.removeFromParent();
        }
      }
    }
  }
  
  void spawnPipe() {
    final pipeGroup = PipeGroup(
      game: this,
      gapSize: pipeGapSize,
    );
    add(pipeGroup);
    // 确保位置立即设置
    pipeGroup.position.x = size.x;
  }
  
  void incrementScore() {
    score++;
    scoreText.updateScore(score);
    audioService.playScore();
    
    // Create score particles at score text position
    final scorePos = Vector2(size.x / 2, 80);
    particleManager.createScoreParticles(scoreText, scorePos);
  }
  
  @override
  void onTap() {
    if (!isGameOver) {
      bird.jump();
      audioService.playJump();
      particleManager.createJumpParticles(bird, bird.position);
    }
  }
  
  void gameOver() {
    if (isGameOver) return;
    
    isGameOver = true;
    pauseEngine();
    audioService.playGameOver();
    audioService.pauseBackgroundMusic();
    
    overlays.add('gameOver');
  }
  
  void reset() {
    score = 0;
    isGameOver = false;
    pipeSpawnTimer = 0;
    
    children.whereType<PipeGroup>().forEach((group) => group.removeFromParent());
    
    bird.reset();
    scoreText.updateScore(0);
    
    audioService.resumeBackgroundMusic();
    resumeEngine();
  }
}