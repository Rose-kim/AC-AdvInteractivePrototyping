//pitch 21-208, velocity 0-127//
class Note {

  int channel, velocity, pitch;   // store the channel, velocity and pitch
  int lifespan;                   // lifespan of note, in frames
  boolean isReleased;             // whether or not the note has been released yet
  float x, y, z;
  float size;
  float col;
  float m = 0;
  float mchange = 0;

  Note(int channel_, int pitch_, int velocity_) {
    this.channel = channel_;
    this.pitch = pitch_;
    this.velocity = velocity_;
    this.lifespan = 200;
    this.isReleased = false;
  
    this.x= +mm;
    //mm++;
    //this.y = map(this.pitch, 21, 108, height/2, -height/2);
    this.y = AccY;
    this.z = AccX;
    this.size = map(this.velocity, 0, 127, 40, 80);
    //this.col = map(this.pitch, 21, 108, 0, 360);
    this.col = breath;
  }

  float a = 1;
  float b = 1;
  //float timeSpan = 2000.0;

  float supershape(float theta, float m, float n1, float n2, float n3) {
    float t1 = abs((1/a)*cos(m * theta / 4));
    t1 = pow(t1, n2);
    float t2 = abs((1/b)*sin(m * theta/4));
    t2 = pow(t2, n3);
    float t3 = t1 + t2;
    float r = pow(t3, - 1 / n1);
    return r;
  }


  //float movement(){
  //  float mil = this.x + milli;
  //  float mil2 = mil+ milli;
  //  return mil2;
  //}

  void display() {
  //  translate(mm*10,0,0);
  //mm++;
    fill(this.col, 100, 100, map(this.lifespan, 100, 0, 100, 80));
    push();
    translate(this.x, this.y, this.z);
    
    //float milreal = movement();
    //float timePosition =+ millis()/timeSpan % 1;
    //translate(this.x, this.y, this.z);
    //translate(timePosition, this.y, this.z);
    //sphere(this.size);

    m = map(sin(mchange), -1, 1, 0, 5);
    mchange += 0.02;

    noStroke();
    lights();
    float r = this.size;
    for (int i = 0; i < total+1; i++) {
      float lat = map(i, 0, total, -HALF_PI, HALF_PI);
      float r2 = supershape(lat, m, 0.2, 1.7, 1.7);
      //float r2 = supershape(lat, 2, 10, 10, 10);
      for (int j = 0; j < total+1; j++) {
        float lon = map(j, 0, total, -PI, PI);
        float r1 = supershape(lon, m, 0.2, 1.7, 1.7);
        //float r1 = supershape(lon, 8, 60, 100, 30);
        float x = r * r1 * cos(lon) * r2 * cos(lat);
        float y = r * r1 * sin(lon) * r2 * cos(lat);
        float z = r * r2 * sin(lat);
        globe[i][j] = new PVector(x, y, z);
      }
    }

    //stroke(255);
    //fill(255);
    //noFill();
    offset += 5;

    for (int i = 0; i < total; i++) {
      //float hu = map(i, 0, total, 0, 255*6);
      //fill((hu + offset) % 255 , 255, 255);
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < total+1; j++) {
        PVector v1 = globe[i][j];
        vertex(v1.x, v1.y, v1.z);
        PVector v2 = globe[i+1][j];
        vertex(v2.x, v2.y, v2.z);
      }
      endShape();
    }

    pop();
  }
}
