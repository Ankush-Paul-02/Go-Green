import 'package:flame/components.dart';
import 'package:go_green/constant.dart';

enum ObstacleType {
  // asteroid,
  // blackHole,
  monster1,
  monster2,
  monster3,
  monster4,
}

class ObstacleData {
  final Vector2 position;
  final ObstacleType type;

  ObstacleData({
    required this.position,
    required this.type,
  });
}

class LevelData {
  final obstacleSpacing = obstacleSize + (playerHeight * 2);
  final leftSide = -(gameWidth / 2) + (obstacleSize / 2);
  final rightSide = (gameWidth / 2) - (obstacleSize / 2);

  List<ObstacleData> level1() {
    List<ObstacleData> level = [];
    level.addAll(
      obstacleRow(
        row: 0,
        item1: ObstacleType.monster1,
        item2: ObstacleType.monster2,
        item3: ObstacleType.monster3,
        item4: ObstacleType.monster4,
      ),
    );
    level.addAll(obstacleRow(
      row: 1,
      item2: ObstacleType.monster1,
      item5: ObstacleType.monster2,
    ));
    level.addAll(obstacleRow(
      row: 2,
      item3: ObstacleType.monster2,
      item4: ObstacleType.monster3,
    ));
    level.addAll(obstacleRow(
      row: 4,
      item1: ObstacleType.monster4,
    ));
    level.addAll(obstacleRow(
      row: 5,
      item4: ObstacleType.monster2,
      item5: ObstacleType.monster4,
    ));
    level.addAll(obstacleRow(
      row: 7,
      item2: ObstacleType.monster1,
    ));
    level.addAll(obstacleRow(
      row: 8,
      item1: ObstacleType.monster1,
      item3: ObstacleType.monster2,
      item5: ObstacleType.monster3,
    ));
    level.addAll(obstacleRow(
      row: 10,
      item1: ObstacleType.monster1,
      item4: ObstacleType.monster4,
      item5: ObstacleType.monster1,
    ));
    level.addAll(obstacleRow(
      row: 11,
      item1: ObstacleType.monster2,
      item2: ObstacleType.monster3,
      item3: ObstacleType.monster4,
    ));
    return level;
  }

  List<ObstacleData> obstacleRow({
    required int row,
    ObstacleType? item1,
    ObstacleType? item2,
    ObstacleType? item3,
    ObstacleType? item4,
    ObstacleType? item5,
  }) {
    List<ObstacleData> content = [];

    final yPosition = obstacleSpacing * row;

    if (row < 0 || row > 14) {
      throw Exception("Row is out of range must be between 0...14");
    }

    if (item1 != null) {
      content.add(ObstacleData(
        position: Vector2(leftSide, yPosition),
        type: item1,
      ));
    }
    if (item2 != null) {
      content.add(ObstacleData(
        position: Vector2(leftSide + (gameWidth / 5), yPosition),
        type: item2,
      ));
    }
    if (item3 != null) {
      content.add(ObstacleData(
        position: Vector2(0, yPosition),
        type: item3,
      ));
    }

    if (item4 != null) {
      content.add(ObstacleData(
        position: Vector2(rightSide - (gameWidth / 5), yPosition),
        type: item4,
      ));
    }
    if (item5 != null) {
      content.add(ObstacleData(
        position: Vector2(rightSide, yPosition),
        type: item5,
      ));
    }

    return content;
  }
}
