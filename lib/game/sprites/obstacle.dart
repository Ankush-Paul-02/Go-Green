import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:go_green/constant.dart';
import 'package:go_green/game/go_green_game.dart';

class Obstacle extends SpriteComponent
    with HasGameRef<GoGreenGame>, CollisionCallbacks {
  Obstacle({
    required this.spritePath,
  });

  final String spritePath;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(spritePath);
    size = Vector2.all(obstacleSize);
    anchor = Anchor.center;
    add(CircleHitbox());
  }
}


class BlackHole extends Obstacle {
  BlackHole() : super(spritePath: 'black-hole.png');
}

class GreenMonster extends Obstacle {
  GreenMonster() : super(spritePath: 'monster-1.png');
}

class YellowMonster extends Obstacle {
  YellowMonster() : super(spritePath: 'monster-2.png');
}

class PinkMonster extends Obstacle {
  PinkMonster() : super(spritePath: 'monster-3.png');
}

class RedMonster extends Obstacle {
  RedMonster() : super(spritePath: 'monster-4.png');
}