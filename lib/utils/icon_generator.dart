import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class IconGenerator {
  static Future<void> generateAppIcon() async {
    const sizes = [
      16, 20, 29, 32, 40, 48, 50, 57, 58, 60, 64, 72, 76, 80, 87, 100, 114,
      120, 128, 144, 152, 167, 180, 192, 256, 512, 1024
    ];
    
    for (final size in sizes) {
      final image = await _createIcon(size.toDouble());
      final pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (pngBytes != null) {
        final file = File('assets/app_icon/icon_${size}x$size.png');
        await file.create(recursive: true);
        await file.writeAsBytes(pngBytes.buffer.asUint8List());
        debugPrint('Generated icon_${size}x$size.png');
      }
    }
  }
  
  static Future<ui.Image> _createIcon(double size) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();
    
    // 背景渐变
    final bgGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [
        const Color(0xFF87CEEB),
        const Color(0xFF4A90E2),
      ],
    );
    
    paint.shader = bgGradient.createShader(
      Rect.fromLTWH(0, 0, size, size),
    );
    
    // 绘制圆角矩形背景
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size, size),
      Radius.circular(size * 0.2),
    );
    canvas.drawRRect(rrect, paint);
    
    // 绘制云朵
    _drawClouds(canvas, size);
    
    // 绘制小鸟
    canvas.save();
    canvas.translate(size * 0.5, size * 0.5);
    canvas.scale(size / 100); // 标准化到100x100的坐标系
    _drawBird(canvas);
    canvas.restore();
    
    // 绘制管道装饰
    _drawPipes(canvas, size);
    
    final picture = recorder.endRecording();
    return picture.toImage(size.toInt(), size.toInt());
  }
  
  static void _drawClouds(Canvas canvas, double size) {
    final cloudPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    
    // 左上角云朵
    canvas.drawCircle(Offset(size * 0.2, size * 0.2), size * 0.08, cloudPaint);
    canvas.drawCircle(Offset(size * 0.28, size * 0.18), size * 0.06, cloudPaint);
    
    // 右下角云朵
    canvas.drawCircle(Offset(size * 0.75, size * 0.8), size * 0.07, cloudPaint);
    canvas.drawCircle(Offset(size * 0.82, size * 0.82), size * 0.05, cloudPaint);
  }
  
  static void _drawBird(Canvas canvas) {
    // 小鸟身体
    final bodyGradient = RadialGradient(
      center: const Alignment(-0.3, -0.5),
      colors: [
        const Color(0xFFFFC107),
        const Color(0xFFFF9800),
      ],
    );
    
    final bodyPaint = Paint()
      ..shader = bodyGradient.createShader(
        const Rect.fromLTWH(-20, -15, 40, 30),
      );
    
    canvas.drawOval(
      const Rect.fromLTWH(-20, -15, 40, 30),
      bodyPaint,
    );
    
    // 翅膀
    final wingPaint = Paint()
      ..color = const Color(0xFFFF5722)
      ..style = PaintingStyle.fill;
    
    final wingPath = Path()
      ..moveTo(-5, 0)
      ..quadraticBezierTo(-20, -5, -25, 5)
      ..quadraticBezierTo(-20, 10, -10, 8)
      ..close();
    
    canvas.drawPath(wingPath, wingPaint);
    
    // 眼睛
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(const Offset(10, -5), 8, eyePaint);
    
    final pupilPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(const Offset(12, -5), 4, pupilPaint);
    
    // 眼睛高光
    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(const Offset(13, -7), 2, highlightPaint);
    
    // 鸟嘴
    final beakPaint = Paint()
      ..color = Colors.orange.shade700
      ..style = PaintingStyle.fill;
    
    final beakPath = Path()
      ..moveTo(18, 0)
      ..lineTo(28, 2)
      ..lineTo(25, 6)
      ..lineTo(18, 4)
      ..close();
    
    canvas.drawPath(beakPath, beakPaint);
  }
  
  static void _drawPipes(Canvas canvas, double size) {
    final pipePaint = Paint()
      ..color = Colors.green.shade600
      ..style = PaintingStyle.fill;
    
    // 左侧管道
    canvas.drawRect(
      Rect.fromLTWH(0, size * 0.7, size * 0.15, size * 0.3),
      pipePaint,
    );
    
    // 右侧管道
    canvas.drawRect(
      Rect.fromLTWH(size * 0.85, 0, size * 0.15, size * 0.3),
      pipePaint,
    );
    
    // 管道帽
    final capPaint = Paint()
      ..color = Colors.green.shade800
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(-size * 0.02, size * 0.68, size * 0.19, size * 0.06),
      capPaint,
    );
    
    canvas.drawRect(
      Rect.fromLTWH(size * 0.83, size * 0.28, size * 0.19, size * 0.06),
      capPaint,
    );
  }
}