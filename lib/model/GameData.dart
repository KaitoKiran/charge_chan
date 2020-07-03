import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

enum LoadingState {empty, charging, discharging }

class GameData extends Model {
  LoadingState _loadingState = LoadingState.empty;

  LoadingState get loadingState => _loadingState;
  void set loadingState(LoadingState newState) { _loadingState = newState; notifyListeners(); }


  ShakeDetector d;
  int load = 0;
  //String txt = "Schüttle bitte";
  GameControl control;
//   int state = 0;


  GameData(){

    control = GameControl();

    d = ShakeDetector.autoStart(
        onPhoneShake: () {
          load++;
          print(load);
          process();
        }
    );
  }

  void process(){
    int temp = load;
    Timer(const Duration(milliseconds: 1200), (){
      if(temp + 1 <= load){
        //changeText("Werde Geschüttelt");
        loadingState = LoadingState.charging;
        notifyListeners();
      }
      else{
        control.vibratePhone(load, this);
        notifyListeners();
      }
    });
  }

  void finishUp(){
    d.stopListening();
  }

}

class GameControl {
  bool vibe = false;

  GameControl()  {
    if (Vibration.hasVibrator() != null) {
      vibe = true;
    }
  }

  void vibratePhone(int load, GameData d){
    if(vibe == true){
      d.loadingState = LoadingState.discharging;
      Vibration.vibrate(duration: load*300);
      Timer(Duration(milliseconds: load*300), (){
        d.load = 0;
        d.loadingState = LoadingState.empty;
      });
    }
  }
}