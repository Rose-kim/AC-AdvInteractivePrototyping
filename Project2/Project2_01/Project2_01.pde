import processing.sound.*;
SoundFile fileA, fileB;
//import controlP5.*;
//ControlP5 cp5;



PFont font;
Starfield[] starsA, starsB;
Planet planets;

float n = 0, y = 0.0, s = 1.0;
float cameraUp_x, cameraUp_y, cameraUp_z;
boolean Blink;
int programState;
int eyeX = 1000, eyeY = 750, eyeZ = 1000;

PShape sun;
PImage sunmap;

void setup() {
  size(2000, 1500, P3D);
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
  background(0);
  text("Press Up or Down to add or subtract planets,", 1000, height-520);
  text("and WASD to control camera", 1000, height-500);
  textAlign(CENTER);
  fill(255);
  cameraControl();
  
  /*------------------CAMERA-------------------*/
  camera(eyeX, mouseY, eyeZ, // eye 
    width/2.0, height/2.0, 0.0, // center
    0.0, 1.0, 0.0); // up


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
  if (keyPressed){
    
    if(key =='w' && eyeZ >=200){
    eyeZ -= 5;
    }
    if(key =='s' && eyeZ <= 3000){
    eyeZ += 5;
    }
    if(key =='d' && eyeX <= 2000){
    eyeX += 5;
    }
    if(key =='a' && eyeX >= 0){
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
