import 'package:flutter/material.dart';
import 'package:japaridor/components/game_board.dart';

class Game extends StatefulWidget {
  const Game({
    Key key,
  }) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var _player = [
    PlayerPiece(1, Colors.amber, Icons.arrow_upward, Position(8, 4)),
    PlayerPiece(2, Colors.greenAccent, Icons.arrow_downward, Position(0, 4)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.repeat),
            color: Colors.white,
            onPressed: () {
              initGame();
            },
          ),
        ),
        Stack(
          children: <Widget>[
                GameBoard(
                  onTapBox: (xi, yi) async {
                    setState(() {
                      _player[0] = PlayerPiece(1, Colors.amber,
                          Icons.arrow_upward, Position(xi, yi));
                    });

                    final winner = _jadgeWin();
                    if (winner == null) {
                      return;
                    }
                    await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('あなたの勝利です'),
                      ),
                    );

                    setState(() {
                      _player[0] = PlayerPiece(
                          1, Colors.amber, Icons.arrow_upward, Position(8, 4));
                    });
                  },
                )
              ] +
              _player,
        ),
      ],
    );
  }

  void initGame() {
    setState(() {
      _player = [
        PlayerPiece(1, Colors.amber, Icons.arrow_upward, Position(8, 4)),
        PlayerPiece(
            2, Colors.greenAccent, Icons.arrow_downward, Position(0, 4)),
      ];
    });
  }

  PlayerPiece _jadgeWin() {
    if (_player[0].position.xi == 0) return _player[0];
  }
}

class PlayerPiece extends StatelessWidget {
  PlayerPiece(this.pid, this.color, this.icon, this.position);

  final int pid;
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
