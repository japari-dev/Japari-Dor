import 'package:flutter/material.dart';
import 'package:japaridor/components/game_board.dart';

class Game extends StatelessWidget {
  const Game({
    Key key,
  }) : super(key: key);

  final _player = const [
    PlayerPiece(Colors.amber, Icons.arrow_upward, Position(8, 4)),
    PlayerPiece(Colors.greenAccent, Icons.arrow_downward, Position(0, 4)),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[GameBoard()] + _player,
    );
  }
}

class PlayerPiece extends StatelessWidget {
  const PlayerPiece(this.color, this.icon, this.position);

  final Color color;
  final IconData icon;
  final Position position;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.x,
      left: position.y,
      child: Container(
        width: 32,
        height: 32,
        color: color,
        child: Icon(icon),
      ),
    );
  }
}

class Position {
  const Position(this.xi, this.yi);

  final int xi;
  final int yi;

  double get x =>
      GameBoard.clearance +
      (GameBoard.boxSize + GameBoard.clearance * 2 + GameBoard.wallThin) * xi;
  double get y =>
      GameBoard.clearance +
      (GameBoard.boxSize + GameBoard.clearance * 2 + GameBoard.wallThin) * yi;
}
