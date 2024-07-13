import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:go_green/constant.dart';
import 'package:go_green/game/go_green_game.dart';

class Player extends SpriteComponent with HasGameRef<GoGreenGame> {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('asteroid.png');
    size = Vector2.all(200);
    position = Vector2(0, -(gameHeight / 2) + (size.y / 2));
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Get the current position of the player
    double newY = position.y + (dt * 400);

    // Check if the player is out of bounds
    if (newY > (gameRef.size.y / 2) - (size.y / 2)) {
      // If the player is out of bounds, set the player's position to the top of the screen
      newY = (gameRef.size.y / 2) - (size.y / 2);
    }
    // Update the player's position
    position.y = newY;
  }

  void move(double dx) {
    // Calculate the new x position
    double newX = position.x + dx;

    // Calculate the minimum x position
    double minX = -(gameRef.size.x / 2) + (size.x / 2);

    // Calculate the maximum x position
    double maxX = (gameRef.size.x / 2) - (size.x / 2);

    // Clamp the new x position to the minimum and maximum x positions
    newX = newX.clamp(minX, maxX);

    position.x = newX; // Update the player's position
  }
}
