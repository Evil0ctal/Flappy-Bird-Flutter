import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Background extends PositionComponent with HasGameReference {
  final double scrollSpeed = 50;
  late List<CloudComponent> clouds;
  late List<MountainComponent> mountains;
  late GroundComponent ground;
  late SunComponent sun;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 天空渐变背景
    add(RectangleComponent(
      size: game.size,
      paint: Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CEEB), // 天蓝色
            Color(0xFFADD8E6), // 浅蓝色
            Color(0xFFE0F6FF), // 非常浅的蓝色
          ],
          stops: [0.0, 0.6, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, game.size.x, game.size.y)),
    ));
    
    // 太阳
    sun = SunComponent();
    sun.position = Vector2(game.size.x * 0.8, game.size.y * 0.2);
    add(sun);
    
    // 远景山脉
    mountains = [];
    for (int i = 0; i < 3; i++) {
      final mountain = MountainComponent(
        position: Vector2(i * game.size.x * 0.6, game.size.y * 0.4),
        mountainSize: Vector2(game.size.x * 0.8, game.size.y * 0.4),
        color: Colors.blueGrey.shade300,
        scrollSpeed: scrollSpeed * 0.2,
      );
      mountains.add(mountain);
      add(mountain);
    }
    
    // 云朵
    clouds = [];
    for (int i = 0; i < 6; i++) {
      final cloud = CloudComponent(
        position: Vector2(
          i * 180.0 + Random().nextDouble() * 100,
          50 + Random().nextDouble() * 150,
        ),
        cloudScale: 0.8 + Random().nextDouble() * 0.4,
      );
      clouds.add(cloud);
      add(cloud);
    }
    
    // 地面
    ground = GroundComponent();
    add(ground);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // 云朵移动
    for (final cloud in clouds) {
      cloud.position.x -= scrollSpeed * 0.3 * dt * cloud.cloudScale;
      
      if (cloud.position.x < -200) {
        cloud.position.x = game.size.x + 100;
        cloud.position.y = 50 + Random().nextDouble() * 150;
      }
    }
    
    // 山脉移动
    for (final mountain in mountains) {
      mountain.update(dt);
    }
  }
}

class SunComponent extends PositionComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 太阳光晕
    add(CircleComponent(
      radius: 60,
      paint: Paint()..color = Colors.yellow.shade100.withValues(alpha: 0.3),
    ));
    
    add(CircleComponent(
      radius: 45,
      paint: Paint()..color = Colors.yellow.shade200.withValues(alpha: 0.4),
    ));
    
    // 太阳主体
    add(CircleComponent(
      radius: 30,
      paint: Paint()..color = Colors.yellow.shade400,
    ));
    
    // 太阳高光
    add(CircleComponent(
      radius: 25,
      position: Vector2(2, -2),
      paint: Paint()..color = Colors.yellow.shade300,
    ));
  }
}

class CloudComponent extends PositionComponent {
  final double cloudScale;
  
  CloudComponent({
    required Vector2 position,
    this.cloudScale = 1.0,
  }) : super(position: position);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    final cloudPaint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    
    // 云朵主体 - 多个圆形组合
    add(CircleComponent(
      radius: 25 * cloudScale,
      position: Vector2(0, 5 * cloudScale),
      paint: cloudPaint,
    ));
    
    add(CircleComponent(
      radius: 35 * cloudScale,
      position: Vector2(30 * cloudScale, 0),
      paint: cloudPaint,
    ));
    
    add(CircleComponent(
      radius: 30 * cloudScale,
      position: Vector2(60 * cloudScale, 2 * cloudScale),
      paint: cloudPaint,
    ));
    
    add(CircleComponent(
      radius: 20 * cloudScale,
      position: Vector2(85 * cloudScale, 8 * cloudScale),
      paint: cloudPaint,
    ));
    
    // 云朵底部填充
    add(RectangleComponent(
      position: Vector2(10 * cloudScale, 10 * cloudScale),
      size: Vector2(65 * cloudScale, 20 * cloudScale),
      paint: cloudPaint,
    ));
  }
}

class MountainComponent extends PositionComponent {
  final Vector2 mountainSize;
  final Color color;
  final double scrollSpeed;
  
  MountainComponent({
    required Vector2 position,
    required this.mountainSize,
    required this.color,
    required this.scrollSpeed,
  }) : super(position: position);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 山的主体
    final mountainPath = [
      Vector2(0, mountainSize.y),
      Vector2(mountainSize.x * 0.3, mountainSize.y * 0.2),
      Vector2(mountainSize.x * 0.5, mountainSize.y * 0.4),
      Vector2(mountainSize.x * 0.7, mountainSize.y * 0.1),
      Vector2(mountainSize.x, mountainSize.y),
    ];
    
    add(PolygonComponent(
      mountainPath,
      paint: Paint()..color = color,
    ));
    
    // 山的阴影面
    final shadowPath = [
      Vector2(mountainSize.x * 0.3, mountainSize.y * 0.2),
      Vector2(mountainSize.x * 0.5, mountainSize.y * 0.4),
      Vector2(mountainSize.x * 0.5, mountainSize.y),
      Vector2(0, mountainSize.y),
    ];
    
    add(PolygonComponent(
      shadowPath,
      paint: Paint()..color = color.withValues(alpha: 0.7),
    ));
  }
  
  @override
  void update(double dt) {
    position.x -= scrollSpeed * dt;
    
    if (position.x < -mountainSize.x) {
      position.x += mountainSize.x * 3;
    }
  }
}

class GroundComponent extends PositionComponent with HasGameReference {
  final double groundHeight = 100;
  final double scrollSpeed = 150;
  late List<RectangleComponent> groundPieces;
  late List<GrassComponent> grassPieces;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    position.y = game.size.y - groundHeight;
    
    final groundPaint = Paint()..color = Colors.brown.shade700;
    
    groundPieces = [];
    grassPieces = [];
    
    for (int i = 0; i < 3; i++) {
      // 土地层
      final groundPiece = RectangleComponent(
        position: Vector2(i * game.size.x, 30),
        size: Vector2(game.size.x, groundHeight),
        paint: groundPaint,
      );
      
      groundPieces.add(groundPiece);
      add(groundPiece);
      
      // 草地层
      final grassPiece = GrassComponent(
        position: Vector2(i * game.size.x, 0),
        grassWidth: game.size.x,
      );
      grassPieces.add(grassPiece);
      add(grassPiece);
      
      // 土地纹理
      for (int j = 0; j < 5; j++) {
        add(RectangleComponent(
          position: Vector2(
            i * game.size.x + Random().nextDouble() * game.size.x,
            40 + Random().nextDouble() * 50,
          ),
          size: Vector2(
            20 + Random().nextDouble() * 30,
            3 + Random().nextDouble() * 5,
          ),
          paint: Paint()..color = Colors.brown.shade800.withValues(alpha: 0.5),
        ));
      }
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    for (int i = 0; i < groundPieces.length; i++) {
      groundPieces[i].position.x -= scrollSpeed * dt;
      grassPieces[i].position.x -= scrollSpeed * dt;
      
      if (groundPieces[i].position.x <= -game.size.x) {
        groundPieces[i].position.x += game.size.x * 3;
        grassPieces[i].position.x += game.size.x * 3;
      }
    }
  }
}

class GrassComponent extends PositionComponent {
  final double grassWidth;
  
  GrassComponent({
    required Vector2 position,
    required this.grassWidth,
  }) : super(position: position);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 草地渐变
    add(RectangleComponent(
      size: Vector2(grassWidth, 30),
      paint: Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green.shade600,
            Colors.green.shade700,
          ],
        ).createShader(Rect.fromLTWH(0, 0, grassWidth, 30)),
    ));
    
    // 草叶细节
    final random = Random();
    for (int i = 0; i < grassWidth ~/ 10; i++) {
      final x = i * 10.0 + random.nextDouble() * 5;
      final height = 8 + random.nextDouble() * 12;
      
      add(PolygonComponent(
        [
          Vector2(0, height),
          Vector2(1, 0),
          Vector2(2, height),
        ],
        position: Vector2(x, 10),
        paint: Paint()..color = Colors.green.shade800,
      ));
    }
  }
}