import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'flappy_game.dart';

class Pipe extends RectangleComponent with CollisionCallbacks {
  final double speed = 150;
  final bool isTopPipe;
  
  Pipe({
    required Vector2 position,
    required Vector2 size,
    required this.isTopPipe,
  }) : super(
          position: position,
          size: size,
          paint: Paint()..color = Colors.green.shade600,
        );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 为管道主体添加碰撞盒
    add(RectangleHitbox(
      size: size,
      position: Vector2.zero(),
    ));
    
    // 主管道渐变
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.green.shade700,
          Colors.green.shade500,
          Colors.green.shade400,
          Colors.green.shade500,
          Colors.green.shade700,
        ],
        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y));
    
    add(RectangleComponent(
      size: size,
      paint: gradientPaint,
    ));
    
    // 管道边缘装饰（顶部或底部）
    final capHeight = 30.0;
    final capY = isTopPipe ? size.y - capHeight : -10.0;
    
    // 为管道帽添加碰撞盒
    add(RectangleHitbox(
      size: Vector2(size.x + 20, capHeight + 10),
      position: Vector2(-10, capY),
    ));
    
    // 管道帽
    add(RectangleComponent(
      position: Vector2(-10, capY),
      size: Vector2(size.x + 20, capHeight + 10),
      paint: Paint()..color = Colors.green.shade800,
    ));
    
    // 管道帽渐变
    final capGradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.green.shade900,
          Colors.green.shade700,
          Colors.green.shade600,
          Colors.green.shade700,
          Colors.green.shade900,
        ],
        stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(-10, capY, size.x + 20, capHeight + 10));
    
    add(RectangleComponent(
      position: Vector2(-10, capY),
      size: Vector2(size.x + 20, capHeight + 10),
      paint: capGradientPaint,
    ));
    
    // 管道高光效果
    add(RectangleComponent(
      position: Vector2(10, 0),
      size: Vector2(15, size.y),
      paint: Paint()..color = Colors.green.shade300.withValues(alpha: 0.4),
    ));
    
    // 管道阴影
    add(RectangleComponent(
      position: Vector2(size.x - 15, 0),
      size: Vector2(15, size.y),
      paint: Paint()..color = Colors.green.shade900.withValues(alpha: 0.3),
    ));
    
    // 管道帽高光
    add(RectangleComponent(
      position: Vector2(-5, capY + 2),
      size: Vector2(size.x + 10, 5),
      paint: Paint()..color = Colors.green.shade400.withValues(alpha: 0.5),
    ));
  }
  
}

class PipeGroup extends PositionComponent {
  final FlappyGame game;
  final double gapSize;
  final Random _random = Random();
  bool scored = false;
  final double speed = 150; // Add speed property
  
  PipeGroup({
    required this.game,
    required this.gapSize,
  });
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    final minPipeHeight = 100.0;
    final maxPipeHeight = game.size.y - gapSize - minPipeHeight - 100;
    
    final topPipeHeight = minPipeHeight + _random.nextDouble() * (maxPipeHeight - minPipeHeight);
    
    final topPipe = Pipe(
      position: Vector2(0, 0),
      size: Vector2(80, topPipeHeight),
      isTopPipe: true,
    );
    
    final bottomPipe = Pipe(
      position: Vector2(0, topPipeHeight + gapSize),
      size: Vector2(80, game.size.y - topPipeHeight - gapSize),
      isTopPipe: false,
    );
    
    add(topPipe);
    add(bottomPipe);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    // Update PipeGroup position instead of individual pipes
    position.x -= speed * dt;
  }
}