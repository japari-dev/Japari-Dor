import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:japaridor/pages/top_page.dart';
import 'package:japaridor/state/game_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAuth.instance.currentUser().then((user) {
    if (user == null) {
      FirebaseAuth.instance.signInAnonymously();
    }
  });
  runApp(
    ChangeNotifierProvider<GameController>(
      create: (_) {
        final game = GameController();
        game.init();
        return game;
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TopPage(),
    );
  }
}
