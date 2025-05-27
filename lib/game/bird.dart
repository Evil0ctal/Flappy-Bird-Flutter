import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'flappy_game.dart';
import 'pipe.dart';

class Bird extends PositionComponent with CollisionCallbacks {
  final FlappyGame game;
  final double jumpForce = -320;
  double velocity = 0;
  double time = 0;
  double wingAngle = 0;
  bool isFlapping = false;
  double flapDuration = 0;
  double tailAngle = 0;
  bool isDying = false;
  double deathRotation = 0;
  double deathTime = 0;
  double birdOpacity = 1.0;
  
  // 小鸟颜色方案
  final Color primaryColor = const Color(0xFFFFC107); // 琥珀色
  final Color secondaryColor = const Color(0xFFFF9800); // 橙色
  final Color accentColor = const Color(0xFFFF5722); // 深橙色
  
  Bird({required this.game}) : super(size: Vector2(40, 30));
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    position = Vector2(game.size.x * 0.3, game.size.y * 0.5);
    anchor = Anchor.center;
    
    // 优化的椭圆形碰撞盒，更贴合小鸟形状
    add(CircleHitbox(
      radius: 12,
      position: Vector2(20, 15),
    ));
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    canvas.save();
    
    // Apply opacity for death animation
    if (birdOpacity < 1.0) {
      canvas.saveLayer(
        Rect.fromLTWH(0, 0, size.x, size.y),
        Paint()..color = Colors.white.withValues(alpha: birdOpacity),
      );
    }
    
    // 绘制阴影
    _drawShadow(canvas);
    
    // 绘制尾巴
    _drawTail(canvas);
    
    // 绘制翅膀（后面）
    _drawWing(canvas, isBack: true);
    
    // 绘制身体
    _drawBody(canvas);
    
    // 绘制翅膀（前面）
    _drawWing(canvas, isBack: false);
    
    // 绘制头部细节
    _drawHead(canvas);
    
    // 绘制眼睛
    _drawEye(canvas);
    
    // 绘制鸟嘴
    _drawBeak(canvas);
    
    // Restore opacity layer if applied
    if (birdOpacity < 1.0) {
      canvas.restore();
    }
    
    canvas.restore();
  }
  
  void _drawShadow(Canvas canvas) {
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(20, 32),
        width: 30,
        height: 10,
      ),
      shadowPaint,
    );
  }
  
  void _drawTail(Canvas canvas) {
    canvas.save();
    canvas.translate(8, 15);
    canvas.rotate(tailAngle);
    
    final tailPaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;
    
    final tailPath = Path()
      ..moveTo(-5, -3)
      ..quadraticBezierTo(-12, -1, -14, 2)
      ..quadraticBezierTo(-12, 5, -8, 6)
      ..quadraticBezierTo(-6, 4, -5, 2)
      ..close();
    
    canvas.drawPath(tailPath, tailPaint);
    
    // 尾巴纹理
    final tailDetailPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    
    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(-6.0 - i * 2.0, -1.0 + i.toDouble()),
        Offset(-10.0 - i * 2.0, 2.0 + i.toDouble()),
        tailDetailPaint,
      );
    }
    
    canvas.restore();
  }
  
  void _drawWing(Canvas canvas, {required bool isBack}) {
    canvas.save();
    
    final wingY = isBack ? 16 : 14;
    final wingX = isBack ? 18 : 16;
    final wingScale = isBack ? 0.9 : 1.0;
    
    canvas.translate(wingX.toDouble(), wingY.toDouble());
    canvas.rotate(wingAngle * (isBack ? -0.8 : 1.0));
    canvas.scale(wingScale);
    
    // 羽毛渐变
    final wingGradient = RadialGradient(
      center: Alignment.topLeft,
      radius: 0.8,
      colors: [
        secondaryColor,
        accentColor,
      ],
    );
    
    final wingPaint = Paint()
      ..shader = wingGradient.createShader(
        Rect.fromLTWH(-15, -5, 20, 15),
      );
    
    final wingPath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(-6, -3, -10, -2)
      ..quadraticBezierTo(-12, 2, -10, 6)
      ..quadraticBezierTo(-6, 8, -2, 8)
      ..quadraticBezierTo(0, 4, 0, 0);
    
    canvas.drawPath(wingPath, wingPaint);
    
    // 羽毛细节
    final featherPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    
    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(-2.0 - i * 3.0, 1.0 + i.toDouble()),
        Offset(-6.0 - i * 3.0, 3.0 + i * 2.0),
        featherPaint,
      );
    }
    
    canvas.restore();
  }
  
  void _drawBody(Canvas canvas) {
    // 主体渐变
    final bodyGradient = RadialGradient(
      center: const Alignment(-0.3, -0.5),
      radius: 1.0,
      colors: [
        primaryColor,
        secondaryColor,
      ],
    );
    
    final bodyPaint = Paint()
      ..shader = bodyGradient.createShader(
        Rect.fromCenter(
          center: const Offset(20, 15),
          width: 32,
          height: 24,
        ),
      );
    
    // 身体主体
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(20, 15),
        width: 32,
        height: 24,
      ),
      bodyPaint,
    );
    
    // 腹部高光
    final bellyPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(22, 18),
        width: 20,
        height: 16,
      ),
      bellyPaint,
    );
  }
  
  void _drawHead(Canvas canvas) {
    // 头部羽毛装饰
    final crestPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
    
    final crestPath = Path()
      ..moveTo(24, 6)
      ..quadraticBezierTo(25, 3, 26, 5)
      ..quadraticBezierTo(27, 2, 28, 5)
      ..quadraticBezierTo(28, 7, 26, 8)
      ..close();
    
    canvas.drawPath(crestPath, crestPaint);
  }
  
  void _drawEye(Canvas canvas) {
    // 眼睛外圈
    final eyeWhitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(28, 12),
        width: 10,
        height: 10,
      ),
      eyeWhitePaint,
    );
    
    // 眼睛边框
    final eyeBorderPaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(28, 12),
        width: 10,
        height: 10,
      ),
      eyeBorderPaint,
    );
    
    // 瞳孔（会跟随速度移动）
    final pupilOffset = velocity.clamp(-200, 200) / 200;
    final pupilPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(29, 12 + pupilOffset * 2),
      3,
      pupilPaint,
    );
    
    // 瞳孔内的反光
    final pupilHighlightPaint = Paint()
      ..color = Colors.blue.shade700
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(29.5, 11.5 + pupilOffset * 2),
      1,
      pupilHighlightPaint,
    );
    
    // 眼睛高光
    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(const Offset(30, 10), 1.5, highlightPaint);
    canvas.drawCircle(const Offset(27, 11), 0.8, highlightPaint);
  }
  
  void _drawBeak(Canvas canvas) {
    // 鸟嘴渐变
    final beakGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.orange.shade600,
        Colors.orange.shade800,
      ],
    );
    
    final beakPaint = Paint()
      ..shader = beakGradient.createShader(
        Rect.fromLTWH(33, 12, 7, 5),
      );
    
    final beakPath = Path()
      ..moveTo(33, 13)
      ..lineTo(40, 14)
      ..lineTo(37, 16.5)
      ..lineTo(33, 16)
      ..close();
    
    canvas.drawPath(beakPath, beakPaint);
    
    // 鸟嘴高光
    final beakHighlightPaint = Paint()
      ..color = Colors.orange.shade400
      ..style = PaintingStyle.fill;
    
    final beakHighlightPath = Path()
      ..moveTo(33, 13)
      ..lineTo(38, 13.5)
      ..lineTo(36, 14.5)
      ..lineTo(33, 14)
      ..close();
    
    canvas.drawPath(beakHighlightPath, beakHighlightPaint);
    
    // 鸟嘴分界线
    final beakLinePaint = Paint()
      ..color = Colors.orange.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    
    canvas.drawLine(
      const Offset(33, 14.5),
      const Offset(38, 14.8),
      beakLinePaint,
    );
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    
    if (!game.isGameOver) {
      // 物理更新
      velocity += game.gravity * dt;
      position.y += velocity * dt;
      
      // 根据速度调整角度（俯冲和上升）
      angle = (velocity / 500).clamp(-0.4, 0.4);
      
      // 尾巴摆动
      tailAngle = sin(time * 3) * 0.1 + angle * 0.3;
      
      // 翅膀扇动动画
      if (isFlapping) {
        flapDuration += dt;
        wingAngle = sin(flapDuration * 25) * 0.4;
        
        if (flapDuration > 0.25) {
          isFlapping = false;
          flapDuration = 0;
        }
      } else {
        // 滑翔时翅膀轻微摆动
        wingAngle = sin(time * 2) * 0.05 + velocity / 1000;
      }
      
      // 边界检查
      if (position.y <= size.y / 2) {
        position.y = size.y / 2;
        velocity = 0;
      }
      
      if (position.y >= game.size.y - size.y / 2) {
        position.y = game.size.y - size.y / 2;
        if (!isDying) {
          startDeathAnimation();
          game.gameOver();
        }
      }
    } else if (isDying) {
      // Death animation
      deathTime += dt;
      deathRotation += dt * 5; // Spin
      angle = deathRotation;
      
      // Fall down
      velocity += game.gravity * dt * 0.5;
      position.y += velocity * dt;
      
      // Fade out
      birdOpacity = (1.0 - deathTime / 2.0).clamp(0.0, 1.0);
    }
  }
  
  void jump() {
    velocity = jumpForce;
    isFlapping = true;
    flapDuration = 0;
  }
  
  void reset() {
    position = Vector2(game.size.x * 0.3, game.size.y * 0.5);
    velocity = 0;
    angle = 0;
    isFlapping = false;
    flapDuration = 0;
    wingAngle = 0;
    tailAngle = 0;
    isDying = false;
    deathRotation = 0;
    deathTime = 0;
    birdOpacity = 1.0;
  }
  
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Pipe && !game.isGameOver && !isDying) {
      game.audioService.playHit();
      game.particleManager.createHitParticles(this, position);
      startDeathAnimation();
      game.gameOver();
    }
  }
  
  void startDeathAnimation() {
    isDying = true;
    deathTime = 0;
    deathRotation = angle;
  }
}