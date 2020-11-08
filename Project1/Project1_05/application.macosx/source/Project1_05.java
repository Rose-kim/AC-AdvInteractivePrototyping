import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Project1_05 extends PApplet {


SoundFile fileA, fileB;
PFont font;
Starfield[] starsA, starsB;
Planet planets;

float n = 0, y = 0.0f, s = 1.0f;
float cameraUp_x, cameraUp_y, cameraUp_z;
boolean Blink;
int programState;
int eyeX = 1000, eyeY = 750, eyeZ = 1000;

PShape sun;
PImage sunmap;

public void setup() {
  
  fileA = new SoundFile(this, "Orbiting Knowhere - The Whole Other.mp3");
  fileB = new SoundFile(this, "Chimes.mp3");
  //fileA.loop();
  font = createFont("AkzidenzGrotesk-Medium.otf", 15);
  textFont(font);
  sunmap = loadImage("sun.jpg");
  planets = new Planet();
  planets.load();
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
}

public void draw() {
  background(0);
  text("Press Up or Down to add or subtract planets,", 1000, height-520);
  text("and WASD to control camera", 1000, height-500);
  textAlign(CENTER);
  fill(255);
  cameraControl();
  
  /*------------------CAMERA-------------------*/
  camera(eyeX, mouseY, eyeZ, // eye 
    width/2.0f, height/2.0f, 0.0f, // center
    0.0f, 1.0f, 0.0f); // up


  /*-------------DRAW STARFIELD----------------*/
  stroke(220+30*sin(s));
  for (int i = 0; i < starsA.length; i++) {
    point(starsA[i].x, starsA[i].y, starsA[i].z);
  }

  stroke(220+30*cos(s)); 
  for (int i = 0; i < starsB.length; i++) {
    point(starsB[i].x, starsB[i].y, starsB[i].z);
  }
  s += 0.3f ;
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

public void keyPressed() {
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

public void cameraControl() {
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
class Planet {
  PShape mercury, venus, earth, mars, jupiter, saturn, uranus, neptune;
  PShape[] planetShapes = {mercury, venus, earth, mars, jupiter, saturn, uranus, neptune};
  PImage mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap;
  PImage[] planetMaps = {mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap};
  String[] planetNames = { "mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"};
  int[] shapeY = {10, 30, 40, 30, 50, 30, 50, 20};
  int[] rotationY = {100, 50, 80, 100, 50, 40, 80, 100};
  int[] translateZ = {200, 250, 320, 400, 510, 660, 730, 830};
  float angle;


  public void load() {
    for (int i = 0; i< planetNames.length; i++) {

      planetMaps[i] = loadImage( planetNames[i] + ".jpg");

      noStroke();
      fill(255);
      sphereDetail(40);

      planetShapes[i] = createShape(SPHERE, shapeY[i]);
      planetShapes[i].setTexture(planetMaps[i]);
    }
  }

  public void make() {
    for (int i = 0; i< planetNames.length; i++) {
      if (programState == i) {
        for (int j = 0; j < i+1 ; j++) {
          pushMatrix();
          rotateY(PI * frameCount / rotationY[j]);
          translate(0, 0, translateZ[j]);
          shape(planetShapes[j]);
          popMatrix();
          
          pushMatrix();
          noFill();
          stroke(255);
          rotateX(PI/2);
          ellipse(0, 0, translateZ[j]*2, translateZ[j]*2);
          popMatrix();
        }
      }
    }
  }
  
  
}
  public void settings() {  size(2000, 1500, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Project1_05" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
