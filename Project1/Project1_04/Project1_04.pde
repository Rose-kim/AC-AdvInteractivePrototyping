import processing.sound.*;
SoundFile fileA, fileB;
PFont font;
Point[] pointsA, pointsB;
Planet planets;

float n = 0, y = 0.0, s = 1.0;
float cameraUp_x, cameraUp_y, cameraUp_z;
boolean Blink;
int programState;

PShape sun;
PImage sunmap;

void setup() {
  size(2000, 1500, P3D);
  fileA = new SoundFile(this, "Orbiting Knowhere - The Whole Other.mp3");
  fileB = new SoundFile(this, "Chimes.mp3");
  fileA.loop();
  font = createFont("AkzidenzGrotesk-Medium.otf", 30);
  textFont(font);
  sunmap = loadImage("sun.jpg");
  planets = new Planet();
  planets.load();
  programState = -1;
  frameRate(30);
  sun = createShape(SPHERE, 150);
  sun.setTexture(sunmap);
  pointsA = new Point[2500];
  for (int i = 0; i < pointsA.length; i++) {
    pointsA[i] = new Point(random(width), random(height), random(-3000));
  }
  pointsB = new Point[2500];
  for (int i = 0; i < pointsB.length; i++) {
    pointsB[i] = new Point(random(width), random(height), random(-3000));
  }
}

void draw() {
  background(0);
  text("Press Up or Down to add or subtract planets", 400, height-500);
  fill(255);
  
  /*------------------CAMERA-------------------*/
  camera(mouseX, mouseY, 1000, // eye 
    width/2.0, height/2.0, 0.0, // center
    0.0, 1.0, 0.0); // up


  /*-------------DRAW STARFIELD----------------*/
  stroke(220+30*sin(s));
  for (int i = 0; i < pointsA.length; i++) {
    point(pointsA[i].x, pointsA[i].y, pointsA[i].z);
  }

  stroke(220+30*cos(s)); 
  for (int i = 0; i < pointsB.length; i++) {
    point(pointsB[i].x, pointsB[i].y, pointsB[i].z);
  }
  s += 0.3 ;
  /*----------DRAW SUN AND MERCURY-------------*/

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
  translate(0.75 * width, 0.6 * height, 50);
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


class Point { 

  float x; 
  float y;
  float z;

  Point (float x_, float y_, float z_) { 
    x = x_; 
    y = y_;
    z = z_;
  }
}
