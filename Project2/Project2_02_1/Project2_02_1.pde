float msSun=100, msMercury=10, msVenus=10, msEarth=10, msMars=10, msJupiter=10, msSaturn=10, msUranus=10, msNeptune=10;
float[] mass = {msSun, msMercury, msVenus, msEarth, msMars, msJupiter, msSaturn, msUranus, msNeptune};
float fg;
float G = 1;
float p1, p2, p3;
PVector sunPos, merPos, venPos, earPos, marPos, jupPos, satPos, uraPos, nepPos;
PVector[] planetPos = {sunPos, merPos, venPos, earPos, marPos, jupPos, satPos, uraPos, nepPos};
float sunMas, merMas, venMas, earMas, marMas, jupMas, satMas, uraMas, nepMas;
float[] planetMass = {sunMas, merMas, venMas, earMas, marMas, jupMas, satMas, uraMas, nepMas};


void setup() {
  size(100, 100);
  sunPos = new PVector(width/2, height/2, 0);
  merPos = new PVector(width/2, height/2, 0);
  venPos = new PVector(width/2, height/2, 0);
  earPos = new PVector(width/2, height/2, 0);
  marPos = new PVector(width/2, height/2, 0);
  jupPos = new PVector(width/2, height/2, 0);
  satPos = new PVector(width/2, height/2, 0);
  uraPos = new PVector(width/2, height/2, 0);
  nepPos = new PVector(width/2, height/2, 0);
}

void draw() {
  background(0);
  fill(255);
  
}

void gforce(){
  for (int i = 1; i < planetPos.length +1 ; i++) {
    float r_vec = planetPos[i].dist(planetPos[i+1]);
    float r_mag = sqrt(sq(planetPos[i].x-planetPos[i+1].x)+sq(planetPos[i].y-planetPos[i+1].y)+sq(planetPos[i].y-planetPos[i+1].y));
    float r_hat = r_vec/r_mag;
    float force_mag = G*planetMass[i]*planetMass[i+1]/sq(r_mag);
    float force_vec = -1 * force_mag * r_hat;
  }  
}

void calForce(){
    star.force = gforce(star,planet1)+gforce(star,planet2)+gforce(star,planet3)
    planet1.force = gforce(planet1,star)+gforce(planet1,planet2)+gforce(planet1,planet3)
    planet2.force = gforce(planet2,star)+gforce(planet2,planet1)+gforce(planet2,planet3)
    planet3.force = gforce(planet3,star)+gforce(planet3,planet1)+gforce(planet3,planet2)
}

void updateMomentum() {
      star.momentum = star.momentum + star.force*dt
    planet1.momentum = planet1.momentum + planet1.force*dt
    planet2.momentum = planet2.momentum + planet2.force*dt
    planet3.momentum = planet3.momentum + planet3.force*dt
}

void updatePosition() {
    star.pos = star.pos + star.momentum/star.mass*dt
    planet1.pos = planet1.pos + planet1.momentum/planet1.mass*dt
    planet2.pos = planet2.pos + planet2.momentum/planet2.mass*dt
    planet3.pos = planet3.pos + planet3.momentum/planet3.mass*dt
    
    t = t + dt
}
