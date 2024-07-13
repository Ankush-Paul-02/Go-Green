import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_green/constant.dart';
import 'package:go_green/game/go_green_game.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoGreenGame game;

  @override
  void initState() {
    super.initState();
    game = GoGreenGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: Center(
          child: FittedBox(
            child: SizedBox(
              width: gameWidth,
              height: gameHeight,
              child: GameWidget(game: game),
            ),
          ),
        ),
      ),
    );
  }
}
