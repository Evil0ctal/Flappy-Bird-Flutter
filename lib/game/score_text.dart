import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameReference {
  ScoreText()
      : super(
          text: '0',
          textRenderer: TextPaint(
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
          anchor: Anchor.topCenter,
        );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(game.size.x / 2, 50);
  }
  
  void updateScore(int score) {
    text = score.toString();
  }
}