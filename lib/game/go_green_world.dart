import 'dart:async';

import 'package:flame/components.dart';
import 'package:go_green/constant.dart';
import 'package:go_green/game/go_green_game.dart';
import 'package:go_green/game/level_data.dart';
import 'package:go_green/game/sprites/obstacle.dart';
import 'package:go_green/game/sprites/spaceship.dart';

import 'sprites/player.dart';

class GoGreenWorld extends World with HasGameRef<GoGreenGame> {
  late final Player player;
  late final SpaceShip spaceShip;

  void loadLevel(List<ObstacleData> levelData) {
    removeAll(children.whereType<Obstacle>().toList());

    for (var data in levelData) {
      Obstacle obstacle;
      if (data.type == ObstacleType.monster1) {
        obstacle = GreenMonster()..position = data.position;
      } else if (data.type == ObstacleType.monster2) {
        obstacle = YellowMonster()..position = data.position;
      } else if (data.type == ObstacleType.monster4) {
        obstacle = RedMonster()..position = data.position;
      } else if (data.type == ObstacleType.monster3) {
        obstacle = PinkMonster()..position = data.position;
      } else {
        continue;
      }
      add(obstacle);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    player = Player();
    spaceShip = SpaceShip();

    add(spaceShip);
    add(player);

    // add(BlackHole()..position = Vector2(0, 0));
    // add(GreenMonster()..position = Vector2(-obstacleSize * 2, 0));
    // add(YellowMonster()..position = Vector2(obstacleSize * 2, 0));
    // add(PinkMonster()..position = Vector2(-obstacleSize * 2, 2));
    // add(RedMonster()..position = Vector2(obstacleSize * 2, 2));
    loadLevel(LevelData().level1());
  }

  @override
  void update(double dt) {
    super.update(dt);
    children.whereType<Obstacle>().forEach((obstacle) {
      obstacle.position.y -= (dt * 400);
      if (obstacle.position.y < -(gameRef.size.y / 2)) {
        obstacle.position.y = extendedHeight;
      }
    });
  }
}
