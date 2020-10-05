Starfield stars;

void setup() {
  size(600, 600);
  stars = new Starfield();
}

void draw() {
  background(0);
  stars.show();
  translate(width/2, height/2);
}
