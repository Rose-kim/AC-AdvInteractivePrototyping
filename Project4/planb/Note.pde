//pitch 21-208, velocity 0-127//
class Note {

  int channel, velocity, pitch;   // store the channel, velocity and pitch
  int lifespan;                   // lifespan of note, in frames
  boolean isReleased;             // whether or not the note has been released yet
  float x, y, z;
  float size;
  float col;

  Note(int channel_, int pitch_, int velocity_) {
    this.channel = channel_;
    this.pitch = pitch_;
    this.velocity = velocity_;
    this.lifespan = 100;
    this.isReleased = false;

    this.x = AccX;
    this.y = map(this.pitch, 21, 108, height/2, -height/2);
    this.z = AccY;
    this.size = map(this.velocity, 0, 127, 1, 40);
    this.col = breath;
  }
  
  void display() {
    fill(col, 50, 50, map(this.lifespan, 100, 0, 200, 50));
    push();
    translate(this.x, this.y, this.z);
    sphere(this.size);
    pop();
  }
}
