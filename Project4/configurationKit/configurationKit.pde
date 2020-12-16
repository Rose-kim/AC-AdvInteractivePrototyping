
import processing.serial.*;
Serial myPort;
String inString = "";
int lf = 10;
float AccY, AccX, AccZ, stretch;
int circlesize = 50;
PImage instruction;

void setup() {
  size(900, 900);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 9600); 
  myPort.bufferUntil(lf);
  instruction = loadImage("instruction.png");
}

void draw() {
  background(#131313);
  image(instruction,0,0);
  translate(width/2, 0);
  noStroke();
  push();
  translate(0, 100);
  fill(75, 235, 235);
  ellipse(stretch, 0, circlesize, circlesize);
  pop();
  push();
  translate(0, 290);
  fill(73, 104, 231);
  ellipse(AccY, 0, circlesize, circlesize);
  pop();
  push();
  translate(0, 480);
  fill(170, 85, 230);
  ellipse(AccX, 0, circlesize, circlesize);
  pop();
  push();
  translate(-width/2, 650);
  fill(236, 126, 213);
  ellipse(AccZ, 0, circlesize, circlesize);
  pop();
}

void serialEvent(Serial p) { 
  inString = p.readString(); 

  if (inString != null) {
    String[] data = split(trim(inString), ":");
    if (data.length == 4) {    
      stretch = map(float(data[0]), 350, 370, -width/2, width/2); //350-360
      AccY = map(float(data[1]), 9000, -16000, -width/2, width/2);
      AccX = map(float(data[2]), 10000, -10000, -width/2, width/2);
      AccZ = map(float(data[3]), -15500, 16700, 0, width/2);
    }
  }
}
