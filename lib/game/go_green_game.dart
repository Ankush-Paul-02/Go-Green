import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:go_green/constant.dart';
import 'package:go_green/game/go_green_world.dart';

class GoGreenGame extends FlameGame<GoGreenWorld>
    with HorizontalDragDetector, HasCollisionDetection {
  final Random _random = Random();
  final int _numStars = 100;
  final List<Offset> _starPositions = [];
  final List<double> _starSizes = [];
  final List<double> _starOpacities = [];
  final List<double> _starTwinkleSpeeds = [];

  late final Paint _starPaint;
  late final Shader _gradientShader;

  GoGreenGame()
      : super(
          world: GoGreenWorld(),
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        ) {
    // Initialize star positions, sizes, opacities, and twinkle speeds
    for (int i = 0; i < _numStars; i++) {
      _starPositions.add(Offset(
        _random.nextDouble() * gameWidth,
        _random.nextDouble() * gameHeight,
      ));
      _starSizes.add(_random.nextDouble() * 2 +
          1); // Stars will have sizes between 1 and 3
      _starOpacities.add(_random.nextDouble());
      _starTwinkleSpeeds
          .add(_random.nextDouble() * 0.5 + 0.1); // Speed between 0.1 and 0.6
    }

    // Create a single Paint object for stars
    _starPaint = Paint()..color = Colors.white;

    // Cache the gradient shader
    _gradientShader = const LinearGradient(
      colors: [
        Color(0xFF000000),
        Color(0xFF0d1b2a),
        Color(0xFF1b263b),
        Color(0xFF415a77),
        Color(0xFF778da9)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(
      const Rect.fromLTWH(
        0,
        0,
        gameWidth,
        gameHeight,
      ),
    );
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update star opacities for twinkling effect
    for (int i = 0; i < _numStars; i++) {
      _starOpacities[i] += _starTwinkleSpeeds[i] * dt;
      if (_starOpacities[i] > 1.0) {
        _starOpacities[i] = 1.0;
        _starTwinkleSpeeds[i] = -_starTwinkleSpeeds[i];
      } else if (_starOpacities[i] < 0.0) {
        _starOpacities[i] = 0.0;
        _starTwinkleSpeeds[i] = -_starTwinkleSpeeds[i];
      }
    }
  }

  @override
  void render(Canvas canvas) {
    // Draw the gradient as background
    final Paint gradientPaint = Paint()..shader = _gradientShader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), gradientPaint);

    // Draw stars with twinkling effect
    for (int i = 0; i < _numStars; i++) {
      _starPaint.color = Colors.white.withOpacity(_starOpacities[i]);
      canvas.drawCircle(_starPositions[i], _starSizes[i], _starPaint);
    }

    // Call the super method to render other components
    super.render(canvas);
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    super.onHorizontalDragUpdate(info);
    world.player.move(info.delta.global.x);
  }
}
