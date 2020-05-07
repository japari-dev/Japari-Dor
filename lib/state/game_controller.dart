import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  var _players;
  var _turn;
  DocumentReference _gameRef;
  List<Player> get players => _players;

  GameController() {
    initGame();
  }

  void initGame() async {
    _turn = 0;
    _players = [
      Player(0, 4, 8),
      Player(1, 4, 0),
    ];
    _gameRef = await Firestore.instance
        .collection('games')
        .add({'createdAt': DateTime.now()});

    Firestore.instance
        .collection('games/${_gameRef.documentID}/actions')
        .orderBy('turn', descending: true)
        .snapshots()
        .listen(
      (event) {
        event.documents.take(2).forEach(
          (action) {
            final data = action.data;
            debugPrint(data.toString());
            _turn = max<int>(_turn, data['turn']);
            movePlayer(data['uid'], data['x'], data['y']);
            notifyListeners();
          },
        );
      },
    );
  }

  void sendAction(int uid, int x, int y) {
    Firestore.instance.collection('games/${_gameRef.documentID}/actions').add(
      {
        'turn': _turn + 1,
        'uid': _turn % 2,
        'x': x,
        'y': y,
      },
    );
  }

  void movePlayer(int uid, int x, int y) {
    _players.firstWhere((player) => player.uid == uid).move(x, y);
  }
}

class Player {
  Player(this.uid, this._x, this._y);

  final int uid;
  int _x;
  int _y;
  int get x => _x;
  int get y => _y;

  void move(int x, int y) {
    _x = x;
    _y = y;
  }
}
