import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    Key key,
    this.boxSize,
  }) : super(key: key);

  final int boxSize;

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
                            : VerticalWall(ri, ci, boxSize))
                        .toList())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: range(0, 17)
                        .map((ci) => ci.toInt().isEven
                            ? HorizontalWall(ri, ci, boxSize)
                            : JointWall())
                        .toList(),
                  ),
          )
          .toList(),
    );
  }
}

class JointWall extends StatelessWidget {
  const JointWall({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: 4,
      height: 4,
    );
  }
}

class HorizontalWall extends StatelessWidget {
  const HorizontalWall(this.x, this.y, this.size, {Key key}) : super(key: key);

  final int x;
  final int y;
  final int size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.blueGrey,
        width: size + 4.0,
        height: 4,
      ),
      onTap: () {
        debugPrint('(type,x,y):(HorizontalWall,$x,$y)');
      },
    );
  }
}

class VerticalWall extends StatelessWidget {
  const VerticalWall(this.x, this.y, this.size, {Key key}) : super(key: key);

  final int x;
  final int y;
  final int size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.blueGrey,
        width: 4,
        height: size + 4.0,
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
  final int size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.brown,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        width: size.toDouble(),
        height: size.toDouble(),
      ),
      onTap: () {
        debugPrint('(type,x,y):(Box,$x,$y)');
      },
    );
  }
}
