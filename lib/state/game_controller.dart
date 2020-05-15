import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  DocumentReference _gameRef;
  List<Player> _players = [
    Player(0, 0, 0),
    Player(1, 0, 0),
  ];
  int _uid;
  int _turn = 0;
  StreamSubscription _actionSub;
  Player _winner;

  List<Player> get players => _players;
  bool get isYourTurn => _turn % 2 == _uid;
  Player get winner => _winner;
  bool get hasWinner => _winner != null;

  GameController() {
    initGame().then((value) => join(0, value.documentID));
  }

  void join(int uid, String gameId) {
    _gameRef = Firestore.instance.collection('games').document(gameId);
    _turn = 0;
    _uid = uid;
    _actionSub?.cancel();
    _actionSub = _gameRef
        .collection('actions')
        .orderBy('turn', descending: true)
        .snapshots()
        .listen(
      (event) {
        event.documents.take(2).forEach(
          (action) {
            final data = action.data;
            debugPrint('action: ' + data.toString());

            _turn = max<int>(_turn, data['turn']);
            movePlayer(data['uid'], data['x'], data['y']);
            _judge();
          },
        );
        notifyListeners();
      },
    );
  }

  Future<DocumentReference> initGame() async {
    final gameRef = await Firestore.instance
        .collection('games')
        .add({'createdAt': DateTime.now()});
    await Firestore.instance
        .collection('games/${gameRef.documentID}/actions')
        .add(
      {'turn': 0, 'uid': 0, 'x': 4, 'y': 8},
    );
    await Firestore.instance
        .collection('games/${gameRef.documentID}/actions')
        .add(
      {'turn': 0, 'uid': 1, 'x': 4, 'y': 0},
    );
    return gameRef;
  }

  void battle() {
    Firestore.instance
        .collection('games')
        .orderBy('createdAt', descending: true)
        .getDocuments()
        .then((event) {
      join(1, event.documents.first.documentID);
    });
  }

  void sendAction(int uid, int x, int y) {
    if (_turn % 2 != _uid) return;
    Firestore.instance.collection('games/${_gameRef.documentID}/actions').add(
      {
        'turn': _turn + 1,
        'uid': _uid,
        'x': x,
        'y': y,
      },
    );
  }

  void movePlayer(int uid, int x, int y) {
    _players.firstWhere((player) => player.uid == uid).move(x, y);
  }

  void _judge() {
    if (_players[0].y == 0) {
      _winner = _players[0];
    } else if (_players[1].y == 8) {
      _winner = _players[1];
    } else {
      _winner = null;
    }
  }

  String toJson() => '''
  {
    "turn": "$_turn",
    "uid": "$_uid",
    "gameId": "${_gameRef?.documentID}"
  }''';
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
