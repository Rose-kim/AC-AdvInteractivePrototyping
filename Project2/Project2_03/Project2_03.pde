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
Planet planets;

float n = 0, y = 0.0, s = 1.0;
float cameraUp_x, cameraUp_y, cameraUp_z;
boolean Blink;
int programState;
float eyeX = 1000, eyeY = 750, zoomZ = 1000;
float upX = 0.0, upY=1.0, upZ=0.0;
float press, flex, pot;

PShape sun;
PImage sunmap;

void setup() {
  size(2000, 1500, P3D);
  printArray(Serial.list()); 
  myPort = new Serial(this, Serial.list()[3], 9600); 
  myPort.bufferUntil(lf);
  fileA = new SoundFile(this, "Orbiting Knowhere - The Whole Other.mp3");
  fileB = new SoundFile(this, "Chimes.mp3");
  //fileA.loop();
  font = createFont("AkzidenzGrotesk-Medium.otf", 15);
  textFont(font);
  sunmap = loadImage("sun.jpg");
  planets = new Planet();
  planets.load();
  programState = -1;
  //frameRate(30);
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
  println(inString);
  background(0);
  text("Press Up or Down to add or subtract planets,", 1000, height-520);
  text("and WASD and physical controller to control camera", 1000, height-500);
  textAlign(CENTER);
  fill(255);
  //cameraControl();
  
  ///*------------------CAMERA-------------------*/
  //camera(eyeX, eyeY, zoomZ, // eye 
  //  width/2.0, height/2.0, 0.0, // center
  //  upX, 1, 0); // up


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
  rotateY(PI * frameCount / 100);
  shape(sun);
  popMatrix();
  
  pointLight(255, 255, 255, 0, 0, 0);  
  planets.make();

  popMatrix();

  noLights();
  pointLight(255, 255, 255, 0, 0, -150); 

  planets.update();
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

//void cameraControl() {
//  if (keyPressed){
    
//    if(key =='w' && eyeY >=200){
//    eyeY += 5;
//    }
//    if(key =='s' && eyeY <= 2000){
//    eyeY -= 5;
//    }
//    if(key =='d' && eyeX <= 2000){
//    eyeX += 5;
//    }
//    if(key =='a' && eyeX >= 0){
//    eyeX -= 5;
//    }
//  }
//}

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
      press = map(float(data[0]), 0, 4090, 10, 100);
      flex = map(float(data[1]), 2700, 1300, 50, 150); //convert from strint-float is okay, but to int is not that well //what if array - vector?
      pot = map(float(data[2]), 0, 3680, 3000, 200);
    } // if and trim function is for clean garbage and protect the code
  }
} 
