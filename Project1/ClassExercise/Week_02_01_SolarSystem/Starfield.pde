class Starfield {

  int NumStars;
  color StarC;
  boolean Blinking;
  int Time;

  Starfield() {
    NumStars = 100;
    StarC = color(255);
    Blinking = false;
    Time = 0;
  }

  void show() {
    stroke(StarC);
    if (millis()>Time + 300) {
      if (Blinking == true) {
        for (int i = 0; i < NumStars; i++) {  
          point(random(width), random(height));
          Blinking = false;
        }} else if (Blinking == false) {
          Blinking = true;
          }
        }
        Time = millis();
      }
    
  }
