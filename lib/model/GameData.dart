import 'dart:async';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

class GameData extends Model {
   ShakeDetector d;
   int load = 0;
   String txt = "Schüttle bitte";
   GameControl control;


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
     Timer(const Duration(seconds: 2), (){
       if(temp + 1 <= load){
         changeText("Werde Geschüttelt");
         notifyListeners();
       }
       else{
         control.vibratePhone(load, this);
       }
     });
   }

   void finishUp(){
     d.stopListening();
   }

   void changeText(String t){
     txt = t;
     notifyListeners();
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
      Vibration.vibrate(duration: load*200);
      while (load > 0) {
        d.changeText("Vibriere");
        sleep(const Duration(milliseconds: 200));
        load--;
      }
      d.changeText("bitte schüttel mich");
    }
  }
}