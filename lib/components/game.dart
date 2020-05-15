import 'package:flutter/material.dart';
import 'package:japaridor/components/game_board.dart';
import 'package:japaridor/state/game_controller.dart';
import 'package:provider/provider.dart';

class Game extends StatelessWidget {
  final uid = 0;
  final _playerColors = [Colors.red, Colors.amberAccent];
  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (context, game, child) {
        if (game.hasWinner) {
          Future.delayed(
              Duration.zero,
              () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('winner: player ${game.winner.uid}'),
                    ),
                  ));
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  game.isYourTurn ? 'your turn' : 'other player\'s turn',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.people),
                  color: Colors.white,
                  onPressed: () {
                    game.battle();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.repeat),
                  color: Colors.white,
                  onPressed: () async {
                    final gameRef = await game.initGame();
                    game.join(0, gameRef.documentID);
                  },
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                    GameBoard(
                      controller: game,
                      onTapBox: _onTapBox,
                    ),
                  ] +
                  game.players.map(
                    (e) {
                      final position = Position(e.x, e.y);
                      return Positioned(
                        left: position.x,
                        top: position.y,
                        child: Container(
                          width: GameBoard.boxSize,
                          height: GameBoard.boxSize,
                          color: _playerColors[e.uid],
                        ),
                      );
                    },
                  ).toList(),
            ),
            Row(
              children: [
                Text(
                  'game: ${game.toJson()}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _onTapBox(GameController controller, x, y) {
    controller.sendAction(uid, x, y);
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
