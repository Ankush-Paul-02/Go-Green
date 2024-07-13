import 'dart:async';

import 'package:flame/components.dart';
import 'package:go_green/game/go_green_game.dart';

import '../player.dart';

class GoGreenWorld extends World with HasGameRef<GoGreenGame> {
  late final Player player;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    player = Player();
    add(player);
  }
}
