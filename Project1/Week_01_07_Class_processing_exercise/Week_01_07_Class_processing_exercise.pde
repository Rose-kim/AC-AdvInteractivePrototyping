float posX = 100.0;
float posY = 100.0;
float velX = 3;
float velY = 3;

float diameter = 100;

float wildCard = 0;

float pV = 0;


//runs before the main loop in preparation
void setup(){
  size(500, 700);
}

//this is the main loop
void draw(){
  background (random(255), random(255), random(255));
  circle(posX, posY, diameter);
  
  float cV = millis() % 2000;
  if (pV > cV) {
    wildCard = random(-3, 3);
    velX *= wildCard;
    println(velX);
  }
  
  if(posX >= width - diameter/2 || posX <= 0 + diameter/2){
    //(pos X + diameter/2 >= width || posX - diameter/2 <= 0)
    velX *= -1;
  }
  posX += velX;
  
   if(posY >= height - diameter/2 || posY <= 0 + diameter/2){
    velY *= -1;
  }
  posY += velY;
  pV = cV;


  //posY = posY + velX;

}
