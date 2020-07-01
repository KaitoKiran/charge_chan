import 'package:flutter/material.dart';
import 'package:flutter_game/model/GameData.dart';
import 'package:scoped_model/scoped_model.dart';


class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Shake it up")
        ),
        body: ScopedModelDescendant<GameData>(
            builder: (context, child, GameData model) =>
            Center(
              child: _GameText(model)
            )
        )
    );
  }
}

class _GameText extends StatelessWidget {

  final GameData model;
  _GameText(this.model);

  @override
  Widget build(BuildContext context) {

    TextStyle style = Theme.of(context).textTheme.headline4;
    return Center(
        child: Text(model.txt, style: style)
    );
  }
}