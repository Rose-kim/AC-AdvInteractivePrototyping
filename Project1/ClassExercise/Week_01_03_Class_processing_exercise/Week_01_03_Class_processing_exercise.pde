float posX=100.0;
float posY=100.0;
float speedX = 3;
float diameter = 100;
//boolean dirX = true; // true = left



//runs before the main loop in preparation
void setup(){
  size(500, 700);
  // circle (250, 350, 100) = circle (width/2, height/2, 100)
}

//this is the main loop
void draw(){
  background (random(255), random(255), random(255));
  circle(posX, posY, diameter);
  
  if(posX >= width - diameter/2 || posX <= 0 + diameter/2){
    //dirX = !dirX;
    speedX = speedX *-1;
  }
  
  posX = posX + speedX;

  //posY = posY + speedX;

}
