import 'package:flutter/material.dart';
import 'package:japaridor/components/game_board.dart';

class TopPage extends StatelessWidget {
  final _player = [
    {'color': Colors.amber, 'direction': Icons.arrow_upward},
    {'color': Colors.greenAccent, 'direction': Icons.arrow_downward},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: Text('Japari-Dor'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: GameBoard(
            boxSize: 32,
          ),
        ),
      ),
    );
  }
}
