import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    Key key,
    this.boxSize,
  }) : super(key: key);

  final double boxSize;
  final double wallThin = 4;
  final double clearance = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: range(0, 17)
          .map(
            (ri) => ri.toInt().isEven
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: range(0, 17)
                        .map((ci) => ci.toInt().isEven
                            ? Box(ri, ci, boxSize)
                            : VerticalWall(
                                ri,
                                ci,
                                boxSize,
                                wallThin,
                                clearance,
                              ))
                        .toList())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: range(0, 17)
                        .map((ci) => ci.toInt().isEven
                            ? HorizontalWall(
                                ri,
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
        debugPrint('(type,x,y):(HorizontalWall,$x,$y)');
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
        debugPrint('(type,x,y):(VerticalWall,$x,$y)');
      },
    );
  }
}

class Box extends StatelessWidget {
  const Box(this.x, this.y, this.size, {Key key}) : super(key: key);

  final int x;
  final int y;
  final double size;

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
        debugPrint('(type,x,y):(Box,$x,$y)');
      },
    );
  }
}
