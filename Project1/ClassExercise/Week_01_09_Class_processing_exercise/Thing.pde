class Thing {
  float posX;
  float posY;
  float velX;
  float velY;
  float diameter;


  Thing(float _x, float _y) {
    posX = _x;
    posY = _y;
    velX = random(1, 4);
    velY = random(1, 4);
    diameter = random(80, 140);
  }

  void display() {
    circle(posX, posY, diameter);
  }

  void move() {
    if (posX >= width - diameter/2 || posX <= 0 + diameter/2) {
      //(pos X + diameter/2 >= width || posX - diameter/2 <= 0)
      velX *= -1;
    }
    posX += velX;

    if (posY >= height - diameter/2 || posY <= 0 + diameter/2) {
      velY *= -1;
    }
    posY += velY;
  }
}
