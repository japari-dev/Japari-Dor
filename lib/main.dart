import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

void main() {
  runApp(MyApp());
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
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: range(0, 17)
              .map(
                (ri) => ri.toInt().isEven
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: range(0, 17)
                            .map((ci) => ci.toInt().isEven
                                ? Container(
                                    color: Colors.brown,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 2),
                                    width: 32,
                                    height: 32,
                                    child: [
                                      [
                                        [16, 8],
                                        [0, 8],
                                      ]
                                          .map((e) =>
                                              ri.toInt() == e[0] &&
                                              ci.toInt() == e[1])
                                          .toList()
                                          .indexOf(true)
                                    ]
                                        .map((e) => e == -1
                                            ? null
                                            : Container(
                                                color: _player[e]['color'],
                                                child: Icon(
                                                    _player[e]['direction']),
                                              ))
                                        .first,
                                  )
                                : Container(
                                    color: Colors.blueGrey,
                                    width: 4,
                                    height: 36,
                                  ))
                            .toList())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: range(0, 17)
                            .map((ci) => ci.toInt().isEven
                                ? Container(
                                    color: Colors.blueGrey,
                                    width: 36,
                                    height: 4,
                                  )
                                : Container(
                                    color: Colors.blueGrey,
                                    width: 4,
                                    height: 4,
                                  ))
                            .toList(),
                      ),
              )
              .toList(),
        ),
      ),
    );
  }
}
