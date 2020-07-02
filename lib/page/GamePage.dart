import 'package:flutter/material.dart';
import 'package:flutter_game/model/GameData.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';


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
              child: _GamePaint(model)
            )
        )
    );
  }
}

class _GamePaint extends StatelessWidget {

  final GameData model;
  _GamePaint(this.model);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: getImage(model.loadingState)
    );
  }

  Image getImage(LoadingState state) {
    switch (state) {
      case LoadingState.discharging: return Image.asset("flutter_chan.gif");
      case LoadingState.charging: return Image.asset("flutter_chan_relax.png");
      case LoadingState.empty: return Image.asset("flutter_chan_relax.png");
    }
  }
}