ArrayList<Thing> things = new ArrayList<Thing>();
float wildCard = 0;
float pV = 0;


//runs before the main loop in preparation
void setup() {
  size(500, 700);
}

// main loop
void draw() {
  background (random(255), random(255), random(255));

  //float cV = millis() % 2000;
  //if (pV > cV) {
  //  wildCard = random(-3, 3);
  //  velX *= wildCard;
  //  println(velX);
  //}

  //pV = cV;
  //array called things, and every member of those, we will make it into the t. every single one of them
  for(Thing currentThing : things){
    currentThing.display();
    currentThing.move();
  }
}

void mouseClicked(){
  things.add(new Thing(mouseX, mouseY));
}
