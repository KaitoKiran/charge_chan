import 'package:flutter/material.dart';
import 'package:charge_chan/page/GamePage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/GameData.dart';

void main() {
  runApp(flutterGame());
}

class flutterGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<flutterGame>{

  GameData model;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GameData>(
        model: model,
        child: MaterialApp(
            title: 'Charge-Chan',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: GamePage()
        )
    );
  }
  @override
  void initState() {
    super.initState();
    model = GameData();
  }

  @override
  void dispose() {
    model.finishUp();
    super.dispose();
  }
}
