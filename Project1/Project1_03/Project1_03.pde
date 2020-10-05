Point[] points;

PImage sunmap;
PShape sun;

PImage mercurymap;
PShape mercury;

PImage venusmap;
PShape venus;

PImage earthmap;
PShape earth;

PImage marsmap;
PShape mars;

PImage jupitermap;
PShape jupiter;

PImage saturnmap;
PShape saturn;

PImage uranusmap;
PShape uranus;

PImage neptunemap;
PShape neptune;


float n = 0;
float x = 1.0, y=0.0;
color bg = color(0);
boolean Blink;
int programState;

float cameraUp_x;
float cameraUp_y;
float cameraUp_z;



void setup() {
  size(2000, 1500, P3D);

  sunmap = loadImage("sun.jpg");
  mercurymap = loadImage("mercury.jpg");
  venusmap = loadImage("venus.jpg");
  earthmap = loadImage("earth.jpg");
  marsmap = loadImage("mars.jpg");
  jupitermap = loadImage("jupiter.jpg");
  saturnmap = loadImage("saturn.jpg");
  uranusmap = loadImage("uranus.jpg");
  neptunemap = loadImage("neptune.jpg");

  noStroke();
  fill(255);

  sphereDetail(40);
  
  programState = 0;

  sun = createShape(SPHERE, 150);
  sun.setTexture(sunmap);

  mercury = createShape(SPHERE, 10);
  mercury.setTexture(mercurymap);

  venus = createShape(SPHERE, 30);
  venus.setTexture(venusmap);

  earth = createShape(SPHERE, 40);
  earth.setTexture(earthmap);

  mars = createShape(SPHERE, 30);
  mars.setTexture(marsmap);

  jupiter = createShape(SPHERE, 100);
  jupiter.setTexture(jupitermap);

  saturn = createShape(SPHERE, 100);
  saturn.setTexture(saturnmap);

  uranus = createShape(SPHERE, 50);
  uranus.setTexture(uranusmap);

  neptune = createShape(SPHERE, 50);
  neptune.setTexture(neptunemap);


  frameRate(30);

  points = new Point [5000];
  for (int i = 0; i < points.length; i++) {
    points[i] = new Point(random(width), random(height), random(-3000));
  }
}

void draw() {
  background(bg);
  
  /*-------------------------------------------*/
  /*------------------CAMERA-------------------*/
  /*-------------------------------------------*/
  
   camera(mouseX, mouseY, 1000, // eye 
         width/2.0, height/2.0, 0.0, // center
         0.0, 1.0, 0.0); // up
         

  /*-------------------------------------------*/
  /*-------------DRAW STARFIELD----------------*/
  /*-------------------------------------------*/


  stroke(127+127*sin(x));
  x += 0.1 ;
  
  for (int i = 0; i < points.length; i++) {
      point(points[i].x, points[i].y, points[i].z);
    }
 stroke(127+127*cos(y/20));
  y += 1 ;
  
  for (int i = 0; i < points.length; i++) {
      point(points[i].x, points[i].y, points[i].z);
    }
 
  /*-------------------------------------------*/
  /*----------DRAW SUN AND MERCURY-------------*/
  /*-------------------------------------------*/

  pushMatrix();
  translate(width/2, height/2, -300);  

  pushMatrix();
  rotateY(PI * frameCount / 100);
  shape(sun);
  popMatrix();
  //println(frameCount);

  pushMatrix();
  pointLight(255, 255, 255, 0, 0, 0);  
  rotateY(PI * frameCount / 100); // /lower - faster
  translate(0, 0, 200);
  shape(mercury);
  popMatrix();


 if(programState == 0){
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 250);
  shape(venus);
  popMatrix();
 } else if(programState == 1){
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 250);
  shape(venus);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 320);
  shape(earth);
  popMatrix();
 } else if(programState == 2){
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 250);
  shape(venus);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 320);
  shape(earth);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 100);
  translate(0, 0, 400);
  shape(mars);
  popMatrix();
 } else if(programState == 3){
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 250);
  shape(venus);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 320);
  shape(earth);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 100);
  translate(0, 0, 400);
  shape(mars);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 450);
  shape(jupiter);
  popMatrix();
 } else if(programState == 4){
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 250);
  shape(venus);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 320);
  shape(earth);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 100);
  translate(0, 0, 400);
  shape(mars);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 450);
  shape(jupiter);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 40);
  translate(0, 0, 550);
  shape(saturn);
  popMatrix();
 } else if(programState == 5){
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 250);
  shape(venus);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 320);
  shape(earth);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 100);
  translate(0, 0, 400);
  shape(mars);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 450);
  shape(jupiter);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 40);
  translate(0, 0, 550);
  shape(saturn);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 650);
  shape(uranus);
  popMatrix();
 } else if(programState == 6){
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 250);
  shape(venus);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 320);
  shape(earth);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 100);
  translate(0, 0, 400);
  shape(mars);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 50);
  translate(0, 0, 450);
  shape(jupiter);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 40);
  translate(0, 0, 550);
  shape(saturn);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 80);
  translate(0, 0, 650);
  shape(uranus);
  popMatrix();
  pushMatrix();
  rotateY(PI * frameCount / 100);
  translate(0, 0, 750);
  shape(neptune);
  popMatrix();
 }
  /*-----------------------*/



  popMatrix();



  noLights();
  pointLight(255, 255, 255, 0, 0, -150); 
  translate(0.75 * width, 0.6 * height, 50);
}

/*-------------------------------------------*/
/*-----DRAW OTHER PLANETS w/ INTERACTION-----*/
/*-------------------------------------------*/

//want to increase and decrease number of planets, and also if I can, camera movement with mouseclick(top view/sideview)

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && programState < 6 ) {
      programState++;
      }
     else if (keyCode == DOWN && programState > 0) {
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
