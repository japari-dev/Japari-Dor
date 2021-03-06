import 'package:flutter/material.dart';
import 'package:japaridor/state/game_controller.dart';
import 'package:quiver/iterables.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    Key key,
    this.controller,
    this.onTapBox,
  }) : super(key: key);

  static double get boxSize => 32;
  static double get wallThin => 4;
  static double get clearance => 2;

  final Function onTapBox;
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: range(0, 17)
          .map(
            (yi) => yi.toInt().isEven
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: range(0, 17)
                        .map((xi) => xi.toInt().isEven
                            ? Box(controller, xi, yi, boxSize, onTapBox)
                            : VerticalWall(
                                yi,
                                xi,
                                boxSize,
                                wallThin,
                                clearance,
                              ))
                        .toList())
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: range(0, 17)
                        .map((ci) => ci.toInt().isEven
                            ? HorizontalWall(
                                yi,
                                ci,
                                boxSize,
                                wallThin,
                                clearance,
                              )
                            : JointWall(wallThin))
                        .toList(),
                  ),
          )
          .toList(),
    );
  }
}

class JointWall extends StatelessWidget {
  const JointWall(this.wallWidth, {Key key}) : super(key: key);

  final double wallWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: wallWidth,
      height: wallWidth,
    );
  }
}

class HorizontalWall extends StatelessWidget {
  const HorizontalWall(this.x, this.y, this.size, this.wallThin, this.clearance,
      {Key key})
      : super(key: key);

  final int x;
  final int y;
  final double size;
  final double wallThin;
  final double clearance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.blueGrey,
        width: size + clearance * 2,
        height: wallThin,
      ),
      onTap: () {
        debugPrint('client: (type,x,y):(HorizontalWall,$x,$y)');
      },
    );
  }
}

class VerticalWall extends StatelessWidget {
  const VerticalWall(this.x, this.y, this.size, this.wallThin, this.clearance,
      {Key key})
      : super(key: key);

  final int x;
  final int y;
  final double size;
  final double wallThin;
  final double clearance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.blueGrey,
        width: wallThin,
        height: size + clearance * 2,
      ),
      onTap: () {
        debugPrint('client: (type,x,y):(VerticalWall,$x,$y)');
      },
    );
  }
}

class Box extends StatelessWidget {
  const Box(this.controller, this.x, this.y, this.size, this.onTapBox,
      {Key key})
      : super(key: key);

  final controller;
  final int x;
  final int y;
  final double size;
  final onTapBox;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.brown,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        width: size,
        height: size,
      ),
      onTap: () {
        debugPrint('client: (type,x,y):(Box,$x,$y)');
        onTapBox(controller, x ~/ 2, y ~/ 2);
      },
    );
  }
}
