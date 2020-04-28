import 'package:flutter/material.dart';
import 'package:japaridor/components/game.dart';

class TopPage extends StatelessWidget {
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
          child: Game(),
        ),
      ),
    );
  }
}
