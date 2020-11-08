class OverButton {

  boolean check(int y) {
    float disX = 132 - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < 52 ) {
      return true;
    } else {
      return false;
    }
  }
}
