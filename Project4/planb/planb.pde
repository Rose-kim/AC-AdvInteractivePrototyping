//ypos: pitch, xpos: accx. zpos: accy, color: breath size: velocity//

//-------SERIAL--------//
import processing.serial.*; 
Serial myPort; 
int lf = 10;
String inString = "";
float AccY, AccX, AccZ, breath;
//-------MIDI--------//
import themidibus.*;
import java.util.*;

MidiBus myBus;
NoteManager nm;


void setup() {
  //-------Genaral setting--------//
  size(1920, 1080, P3D); // Instagram, YouTube Live Dimensions
  colorMode(HSB, 360, 100, 100);
  frameRate(60); //for Mac Update
  //-------MIDI setting--------//
  MidiBus.list(); // List all available Midi devices on STDOUTPUT
  myBus = new MidiBus(this, 0, 1);
  nm = new NoteManager();
  //-------serial setting--------//
  myPort = new Serial(this, Serial.list()[3], 9600); 
  myPort.bufferUntil(lf);
}

void draw() {
  camera(mouseX, mouseY, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  background(#f1f1f1);

  noStroke();
  sphereDetail(4);
  push();
  translate(width/2, height/2);
  nm.track();
  pop();
}

void noteOn(int channel, int pitch, int velocity) {
  nm.addNote(new Note(channel, pitch, velocity));
}

void noteOff(int channel, int pitch, int velocity) {
  nm.releaseNote(new Note(channel, pitch, velocity));
}

void serialEvent(Serial p) { 
  inString = p.readString(); 

  if (inString != null) {
    String[] data = split(trim(inString), ":");
    if (data.length == 4) {    
      breath = map(float(data[0]), 340, 370, 0, 360); //350-360
      AccY = map(float(data[1]), -16000, 9000, -height/2.0, height/2.0);
      AccX = map(float(data[2]), 10000, -10000, -width/2, width/2);
      AccZ = map(float(data[3]), -15500, 16700, 0, width/2);
    }
  }
}
