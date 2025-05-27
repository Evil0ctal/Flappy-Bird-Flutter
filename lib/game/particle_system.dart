import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class StarParticle extends PositionComponent {
  final Vector2 velocity;
  final double lifespan;
  double currentLife = 0;
  final Color color;
  final double rotationSpeed;
  double currentRotation = 0;
  double particleOpacity = 1.0;
  
  StarParticle({
    required Vector2 position,
    required this.velocity,
    required this.lifespan,
    required this.color,
    this.rotationSpeed = 3.0,
  }) : super(position: position, size: Vector2.all(10));
  
  @override
  void update(double dt) {
    super.update(dt);
    
    currentLife += dt;
    if (currentLife >= lifespan) {
      removeFromParent();
      return;
    }
    
    position += velocity * dt;
    currentRotation += rotationSpeed * dt;
    
    // Apply gravity
    velocity.y += 200 * dt;
    
    // Fade out
    particleOpacity = 1.0 - (currentLife / lifespan);
  }
  
  @override
  void render(Canvas canvas) {
    canvas.save();
    
    canvas.translate(size.x / 2, size.y / 2);
    canvas.rotate(currentRotation);
    
    final paint = Paint()
      ..color = color.withValues(alpha: particleOpacity)
      ..style = PaintingStyle.fill;
    
    // Draw star
    final path = Path();
    final outerRadius = size.x / 2;
    final innerRadius = outerRadius * 0.5;
    
    for (int i = 0; i < 5; i++) {
      final outerAngle = (i * 72 - 90) * (pi / 180);
      final innerAngle = ((i * 72 + 36) - 90) * (pi / 180);
      
      if (i == 0) {
        path.moveTo(
          cos(outerAngle) * outerRadius,
          sin(outerAngle) * outerRadius,
        );
      } else {
        path.lineTo(
          cos(outerAngle) * outerRadius,
          sin(outerAngle) * outerRadius,
        );
      }
      
      path.lineTo(
        cos(innerAngle) * innerRadius,
        sin(innerAngle) * innerRadius,
      );
    }
    
    path.close();
    canvas.drawPath(path, paint);
    
    canvas.restore();
  }
}

class FeatherParticle extends PositionComponent {
  final Vector2 velocity;
  final double lifespan;
  double currentLife = 0;
  final Color color;
  double swayTime = 0;
  double particleOpacity = 1.0;
  
  FeatherParticle({
    required Vector2 position,
    required this.velocity,
    required this.lifespan,
    required this.color,
  }) : super(position: position, size: Vector2(12, 8));
  
  @override
  void update(double dt) {
    super.update(dt);
    
    currentLife += dt;
    swayTime += dt;
    
    if (currentLife >= lifespan) {
      removeFromParent();
      return;
    }
    
    // Feather floating motion
    position.x += velocity.x * dt + sin(swayTime * 3) * 20 * dt;
    position.y += velocity.y * dt;
    
    // Slow down and float
    velocity.y += 50 * dt; // Light gravity
    velocity.x *= 0.99;
    
    // Rotation based on movement
    angle = sin(swayTime * 2) * 0.3;
    
    // Fade out
    particleOpacity = 1.0 - (currentLife / lifespan);
  }
  
  @override
  void render(Canvas canvas) {
    canvas.save();
    
    final paint = Paint()
      ..color = color.withValues(alpha: particleOpacity)
      ..style = PaintingStyle.fill;
    
    // Draw feather shape
    final path = Path()
      ..moveTo(0, size.y / 2)
      ..quadraticBezierTo(size.x / 4, 0, size.x / 2, 0)
      ..quadraticBezierTo(size.x * 3/4, 0, size.x, size.y / 2)
      ..quadraticBezierTo(size.x * 3/4, size.y, size.x / 2, size.y)
      ..quadraticBezierTo(size.x / 4, size.y, 0, size.y / 2)
      ..close();
    
    canvas.drawPath(path, paint);
    
    // Draw center line with darker color
    final darkerColor = Color.lerp(color, Colors.black, 0.3)!;
    final linePaint = Paint()
      ..color = darkerColor.withValues(alpha: particleOpacity * 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    
    canvas.drawLine(
      Offset(0, size.y / 2),
      Offset(size.x, size.y / 2),
      linePaint,
    );
    
    canvas.restore();
  }
}

class ScoreParticle extends TextComponent {
  final Vector2 velocity;
  final double lifespan;
  double currentLife = 0;
  double particleOpacity = 1.0;
  
  ScoreParticle({
    required Vector2 position,
    required String text,
    required this.velocity,
    this.lifespan = 1.0,
  }) : super(
    text: text,
    position: position,
    textRenderer: TextPaint(
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 4,
            color: Colors.black54,
            offset: Offset(2, 2),
          ),
        ],
      ),
    ),
  );
  
  @override
  void render(Canvas canvas) {
    if (particleOpacity < 1.0) {
      textRenderer = TextPaint(
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white.withValues(alpha: particleOpacity),
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black54.withValues(alpha: particleOpacity),
              offset: const Offset(2, 2),
            ),
          ],
        ),
      );
    }
    super.render(canvas);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    currentLife += dt;
    if (currentLife >= lifespan) {
      removeFromParent();
      return;
    }
    
    position += velocity * dt;
    
    // Fade and scale
    final progress = currentLife / lifespan;
    particleOpacity = 1.0 - progress;
    scale = Vector2.all(1.0 + progress * 0.5);
  }
}

// Cloud/dust particle for jump effect
class CloudParticle extends PositionComponent {
  Vector2 velocity;
  final double lifespan;
  double currentLife = 0;
  final Color color;
  double particleOpacity = 1.0;
  final double particleSize;
  
  CloudParticle({
    required Vector2 position,
    required this.velocity,
    required this.lifespan,
    required this.color,
    double size = 10,
  }) : particleSize = size,
       super(position: position, size: Vector2.all(size));
  
  @override
  void update(double dt) {
    super.update(dt);
    
    currentLife += dt;
    if (currentLife >= lifespan) {
      removeFromParent();
      return;
    }
    
    position += velocity * dt;
    
    // Slow down
    velocity *= 0.95;
    
    // Fade out and expand
    final progress = currentLife / lifespan;
    particleOpacity = 1.0 - progress;
    size = Vector2.all(particleSize * (1.0 + progress * 0.5));
  }
  
  @override
  void render(Canvas canvas) {
    canvas.save();
    
    final paint = Paint()
      ..color = color.withValues(alpha: particleOpacity * 0.6)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    
    // Draw soft circle
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
    
    canvas.restore();
  }
}

// Speed line particle for motion effect
class SpeedLineParticle extends PositionComponent {
  final Vector2 velocity;
  final double lifespan;
  double currentLife = 0;
  final Color color;
  double particleOpacity = 1.0;
  
  SpeedLineParticle({
    required Vector2 position,
    required this.velocity,
    required this.lifespan,
    required this.color,
  }) : super(position: position, size: Vector2(2, 20));
  
  @override
  void update(double dt) {
    super.update(dt);
    
    currentLife += dt;
    if (currentLife >= lifespan) {
      removeFromParent();
      return;
    }
    
    position += velocity * dt;
    
    // Fade out
    particleOpacity = 1.0 - (currentLife / lifespan);
  }
  
  @override
  void render(Canvas canvas) {
    canvas.save();
    
    final paint = Paint()
      ..color = color.withValues(alpha: particleOpacity)
      ..style = PaintingStyle.fill;
    
    // Draw vertical line
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        const Radius.circular(1),
      ),
      paint,
    );
    
    canvas.restore();
  }
}

class ParticleManager {
  final Random _random = Random();
  
  void createJumpParticles(PositionComponent parent, Vector2 position) {
    // Create a small puff of air/dust effect when jumping
    for (int i = 0; i < 3; i++) {
      // Particles go downward and slightly to the sides
      final angleOffset = (i - 1) * 0.3; // -0.3, 0, 0.3
      final angle = pi / 2 + angleOffset; // Downward direction
      final speed = 80 + _random.nextDouble() * 40;
      final velocity = Vector2(
        cos(angle) * speed,
        sin(angle) * speed,
      );
      
      // Create small cloud/dust particles
      parent.add(CloudParticle(
        position: position.clone() + Vector2(0, 10), // Start below bird
        velocity: velocity,
        lifespan: 0.6,
        color: Colors.white.withValues(alpha: 0.4),
        size: 8 + _random.nextDouble() * 4,
      ));
    }
    
    // Add a single speed line effect
    parent.add(SpeedLineParticle(
      position: position.clone(),
      velocity: Vector2(0, -200), // Upward motion
      lifespan: 0.3,
      color: Colors.lightBlue.shade200,
    ));
  }
  
  void createScoreParticles(PositionComponent parent, Vector2 position) {
    // Create star burst
    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * pi * 2;
      final speed = 100 + _random.nextDouble() * 50;
      final velocity = Vector2(
        cos(angle) * speed,
        sin(angle) * speed,
      );
      
      parent.add(StarParticle(
        position: position.clone(),
        velocity: velocity,
        lifespan: 0.8,
        color: Colors.yellow,
        rotationSpeed: _random.nextDouble() * 4 + 2,
      ));
    }
    
    // Create +1 text
    parent.add(ScoreParticle(
      position: position.clone() - Vector2(10, 20),
      text: '+1',
      velocity: Vector2(0, -50),
      lifespan: 1.0,
    ));
  }
  
  void createHitParticles(PositionComponent parent, Vector2 position) {
    // Create feather explosion
    for (int i = 0; i < 12; i++) {
      final angle = _random.nextDouble() * pi * 2;
      final speed = 100 + _random.nextDouble() * 150;
      final velocity = Vector2(
        cos(angle) * speed,
        sin(angle) * speed,
      );
      
      final colors = [
        Colors.orange.shade400,
        Colors.yellow.shade600,
        Colors.red.shade400,
      ];
      
      parent.add(FeatherParticle(
        position: position.clone(),
        velocity: velocity,
        lifespan: 2.0,
        color: colors[i % colors.length],
      ));
    }
  }
}