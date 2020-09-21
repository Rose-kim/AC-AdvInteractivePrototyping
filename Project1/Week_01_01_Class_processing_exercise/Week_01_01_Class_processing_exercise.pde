float posX=100.0;
float posY=100.0;
float velXY = 3;



//runs before the main loop in preparation
void setup(){
  size(500, 700);
  // circle (250, 350, 100) = circle (width/2, height/2, 100)
}

//this is the main loop
void draw(){
  circle(posX, posY, 100);
  posX = posX + velXY;
  println("Pos X: " + posX); // print in the next line
  posY = posY + velXY;
  println("Pos Y: " + posY);
}
