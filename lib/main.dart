import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:go_green/game_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  runApp(const GameApp());
}
