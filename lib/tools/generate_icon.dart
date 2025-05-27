import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Generate main icon
  await generateIcon('assets/images/app_icon.png', 1024, includeBackground: true);
  
  // Generate foreground icon for Android adaptive icon
  await generateIcon('assets/images/app_icon_foreground.png', 1024, includeBackground: false);
  
  // Use debugPrint in production code
  debugPrint('Icons generated successfully!');
  exit(0);
}

Future<void> generateIcon(String path, int size, {required bool includeBackground}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()));
  
  if (includeBackground) {
    // 背景渐变
    final bgGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [
        const Color(0xFF87CEEB),
        const Color(0xFF4A90E2),
      ],
    );
    
    final bgPaint = Paint()
      ..shader = bgGradient.createShader(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      );
    
    // iOS风格圆角矩形
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      Radius.circular(size * 0.2),
    );
    canvas.drawRRect(rrect, bgPaint);
    
    // 绘制云朵
    _drawClouds(canvas, size.toDouble());
  }
  
  // 绘制小鸟
  canvas.save();
  canvas.translate(size * 0.5, size * 0.5);
  canvas.scale(size / 100); // 标准化到100x100的坐标系
  _drawBird(canvas);
  canvas.restore();
  
  // 绘制管道装饰
  if (includeBackground) {
    _drawPipes(canvas, size.toDouble());
  }
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(size, size);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  
  if (byteData != null) {
    final file = File(path);
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List());
  }
}

void _drawClouds(Canvas canvas, double size) {
  final cloudPaint = Paint()
    ..color = Colors.white.withValues(alpha: 0.6)
    ..style = PaintingStyle.fill;
  
  // 左上角云朵
  canvas.drawCircle(Offset(size * 0.2, size * 0.25), size * 0.06, cloudPaint);
  canvas.drawCircle(Offset(size * 0.26, size * 0.23), size * 0.05, cloudPaint);
  canvas.drawCircle(Offset(size * 0.23, size * 0.28), size * 0.04, cloudPaint);
  
  // 右下角云朵
  canvas.drawCircle(Offset(size * 0.75, size * 0.75), size * 0.05, cloudPaint);
  canvas.drawCircle(Offset(size * 0.8, size * 0.77), size * 0.04, cloudPaint);
}

void _drawBird(Canvas canvas) {
  // 小鸟阴影
  final shadowPaint = Paint()
    ..color = Colors.black.withValues(alpha: 0.2)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
  
  canvas.drawOval(
    const Rect.fromLTWH(-18, 12, 36, 12),
    shadowPaint,
  );
  
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
  
  // 腹部高光
  final bellyPaint = Paint()
    ..color = const Color(0xFFFFC107).withValues(alpha: 0.4)
    ..style = PaintingStyle.fill;
  
  canvas.drawOval(
    const Rect.fromLTWH(-12, -5, 24, 20),
    bellyPaint,
  );
  
  // 翅膀
  final wingPaint = Paint()
    ..color = const Color(0xFFFF5722)
    ..style = PaintingStyle.fill;
  
  final wingPath = Path()
    ..moveTo(-8, 0)
    ..quadraticBezierTo(-20, -8, -22, 0)
    ..quadraticBezierTo(-20, 8, -12, 10)
    ..quadraticBezierTo(-8, 6, -8, 0);
  
  canvas.drawPath(wingPath, wingPaint);
  
  // 翅膀细节
  final wingDetailPaint = Paint()
    ..color = const Color(0xFFFF9800)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;
  
  canvas.drawLine(const Offset(-12, 2), const Offset(-18, 4), wingDetailPaint);
  canvas.drawLine(const Offset(-14, 5), const Offset(-19, 7), wingDetailPaint);
  
  // 眼睛背景
  final eyeBgPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  
  canvas.drawOval(
    const Rect.fromLTWH(5, -10, 14, 14),
    eyeBgPaint,
  );
  
  // 瞳孔
  final pupilPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;
  
  canvas.drawCircle(const Offset(13, -3), 5, pupilPaint);
  
  // 瞳孔内部
  final innerPupilPaint = Paint()
    ..color = Colors.blue.shade700
    ..style = PaintingStyle.fill;
  
  canvas.drawCircle(const Offset(13, -3), 2, innerPupilPaint);
  
  // 眼睛高光
  final highlightPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  
  canvas.drawCircle(const Offset(15, -5), 2.5, highlightPaint);
  canvas.drawCircle(const Offset(10, -4), 1.2, highlightPaint);
  
  // 鸟嘴
  final beakGradient = LinearGradient(
    colors: [
      Colors.orange.shade600,
      Colors.orange.shade800,
    ],
  );
  
  final beakPaint = Paint()
    ..shader = beakGradient.createShader(
      const Rect.fromLTWH(18, -2, 12, 8),
    );
  
  final beakPath = Path()
    ..moveTo(18, 0)
    ..lineTo(30, 2)
    ..lineTo(26, 6)
    ..lineTo(18, 4)
    ..close();
  
  canvas.drawPath(beakPath, beakPaint);
  
  // 鸟嘴高光
  final beakHighlightPaint = Paint()
    ..color = Colors.orange.shade400
    ..style = PaintingStyle.fill;
  
  final beakHighlightPath = Path()
    ..moveTo(18, 0)
    ..lineTo(26, 1)
    ..lineTo(24, 2.5)
    ..lineTo(18, 1.5)
    ..close();
  
  canvas.drawPath(beakHighlightPath, beakHighlightPaint);
}

void _drawPipes(Canvas canvas, double size) {
  // 左下角管道
  final pipeGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Colors.green.shade700,
      Colors.green.shade500,
      Colors.green.shade600,
    ],
  );
  
  final pipePaint = Paint()
    ..shader = pipeGradient.createShader(
      Rect.fromLTWH(0, size * 0.7, size * 0.12, size * 0.3),
    );
  
  canvas.drawRect(
    Rect.fromLTWH(0, size * 0.75, size * 0.12, size * 0.25),
    pipePaint,
  );
  
  // 右上角管道
  canvas.drawRect(
    Rect.fromLTWH(size * 0.88, 0, size * 0.12, size * 0.25),
    pipePaint,
  );
  
  // 管道帽
  final capPaint = Paint()
    ..color = Colors.green.shade800
    ..style = PaintingStyle.fill;
  
  canvas.drawRect(
    Rect.fromLTWH(-size * 0.01, size * 0.73, size * 0.14, size * 0.04),
    capPaint,
  );
  
  canvas.drawRect(
    Rect.fromLTWH(size * 0.87, size * 0.23, size * 0.14, size * 0.04),
    capPaint,
  );
}