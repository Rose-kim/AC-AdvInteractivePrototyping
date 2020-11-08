import processing.sound.*;
import processing.serial.*; 

SoundFile fileA, fileB;
//import controlP5.*;
//ControlP5 cp5;

Serial myPort;
String inString = "";
int lf = 10;      // ASCII linefeed 


PFont font;
Starfield[] starsA, starsB;
//Planet planets;

float n = 0, y = 0.0, s = 1.0;
float cameraUp_x, cameraUp_y, cameraUp_z;
boolean Blink;
int programState;
float eyeX = 1000, eyeY = 750, zoomZ = 1000;
float upX = 0.0, upY=1.0, upZ=0.0;
float press, flex, pot;

PShape sun;
PImage sunmap;


PShape mercury, venus, earth, mars, jupiter, saturn, uranus, neptune;
PShape[] planetShapes = {mercury, venus, earth, mars, jupiter, saturn, uranus, neptune};
PImage mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap;
PImage[] planetMaps = {mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap};
String[] planetNames = { "mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"};
float volMe, volVe, volEa, volMa, volJu, volSa, volUr, volNe;
float[] shapeY = {volMe, volVe, volEa, volMa, volJu, volSa, volUr, volNe};
 int[] rotationY = {50, 20, 80, 100, 50, 40, 80, 20};
float posMe, posVe, posEa, posMa, posJu, posSa, posUr, posNe;
float[] translateZ = {posMe, posVe, posEa, posMa, posJu, posSa, posUr, posNe};

float angle;


void setup() {
  size(2000, 1500, P3D);
  printArray(Serial.list()); 
  myPort = new Serial(this, Serial.list()[3], 9600); 
  myPort.bufferUntil(lf);
  fileA = new SoundFile(this, "Orbiting Knowhere - The Whole Other.mp3");
  fileB = new SoundFile(this, "Chimes.mp3");
  fileA.loop();
  //font = createFont("AkzidenzGrotesk-Medium.otf", 15);
  //textFont(font);
  sunmap = loadImage("sun.jpg");
  // planets = new Planet();
  load();
  programState = -1;
  frameRate(30);
  sun = createShape(SPHERE, 150);
  sun.setTexture(sunmap);
  starsA = new Starfield[3000];
  for (int i = 0; i < starsA.length; i++) {
    starsA[i] = new Starfield(random(width), random(height), random(-3000, 3000));
  }
  starsB = new Starfield[3000];   
  for (int i = 0; i < starsB.length; i++) {
    starsB[i] = new Starfield(random(width), random(height), random(-3000, 3000));
  }

  //cp5 = new ControlP5(this);
  //cp5.addSlider("radius").setPosition(200, 100).setSize(20, 200).setRange(0, 1).setNumberOfTickMarks(11);
  background(0);
}

void draw() {
  load();
  println(inString);
  background(0);

  textAlign(CENTER);
  fill(255);
  cameraControl();

  ///*------------------CAMERA-------------------*/
  camera(eyeX, eyeY, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);


  /*-------------DRAW STARFIELD----------------*/
  stroke(220+30*sin(s));
  for (int i = 0; i < starsA.length; i++) {
    point(starsA[i].x, starsA[i].y, starsA[i].z);
  }

  stroke(220+30*cos(s)); 
  for (int i = 0; i < starsB.length; i++) {
    point(starsB[i].x, starsB[i].y, starsB[i].z);
  }
  s += 0.3 ;
  /*----------DRAW PLANETS-------------*/

  pushMatrix();

  translate(width/2, height/2, -300); 

  pushMatrix();
  rotateY(PI * frameCount / 20);
  shape(sun);
  popMatrix();

  pointLight(press, 255, 255, 0, 0, 0);  
  make();

  popMatrix();

  noLights();
  pointLight(press, 255, 255, 0, 0, -150); 


  if (programState == 0) {
    translateZ[0] = flex;
    shapeY[0] = pot;
  } else if (programState >0 &&programState <= 6) {
    translateZ[programState] = translateZ[programState-1]+flex;
    shapeY[programState] = pot;
  }
}

/*-----INTERACTION-----*/

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && programState <= 6 ) {
      fileB.play();
      programState++;
    } 
    if (keyCode == DOWN && programState >= 0) {
      fileB.play();
      programState--;
    }
  }
}

void cameraControl() {
  if (keyPressed) {

    if (key =='s' && eyeY >=200) {
      eyeY += 5;
    }
    if (key =='w' && eyeY <= 2000) {
      eyeY -= 5;
    }
    if (key =='d' && eyeX <= 2000) {
      eyeX += 5;
    }
    if (key =='a' && eyeX >= 0) {
      eyeX -= 5;
    }
  }
}

/*-----STARFIELDS-----*/

class Starfield { 

  float x; 
  float y;
  float z;

  Starfield (float x_, float y_, float z_) { 
    x = x_; 
    y = y_;
    z = z_;
  }
}

void serialEvent(Serial p) { 
  inString = p.readString();
  if (inString != null) {
    String[] data = split(trim(inString), ':');
    printArray(data);
    if (data.length == 3) {
      press = map(float(data[2]), 0, 3000, 255, 0);
      flex = map(float(data[1]), 2500, 1500, 200, 400);
      pot = map(float(data[0]), 0, 4000, 20, 100);
    } // if and trim function is for clean garbage and protect the code
  }
} 

void load() {
  for (int i = 0; i< planetNames.length; i++) {

    planetMaps[i] = loadImage( planetNames[i] + ".jpg");

    noStroke();
    fill(255);
    sphereDetail(40);

    planetShapes[i] = createShape(SPHERE, shapeY[i]);
    planetShapes[i].setTexture(planetMaps[i]);
  }
}

void make() {

  for (int i = 0; i < programState+1; i++) {
    pushMatrix();
    rotateY(PI*frameCount/ rotationY[i]);
    translate(0, 0, translateZ[i]);
    shape(planetShapes[i]);
    popMatrix();
    pushMatrix();
    noFill();
    stroke(255);
    rotateX(PI/2);
    ellipse(0, 0, translateZ[i]*2, translateZ[i]*2);
    popMatrix();
  }
}
