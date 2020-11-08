class Planet {
  PShape mercury, venus, earth, mars, jupiter, saturn, uranus, neptune;
  PShape[] planetShapes = {mercury, venus, earth, mars, jupiter, saturn, uranus, neptune};
  PImage mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap;
  PImage[] planetMaps = {mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap};
  String[] planetNames = { "mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"};
  int meR=10,vR=30,eR=40,maR=30,jR=100,sR=100,uR=50,nR=50;
  int[] shapeY = {meR,vR,eR,maR,jR,sR,uR,nR};
  int[] rotationY = {100, 50, 80, 100, 50, 40, 80, 100};
  int[] translateZ = {200, 250, 320, 400, 510, 660, 730, 830};
  float angle;


  void load() {
    for (int i = 0; i< planetNames.length; i++) {

      planetMaps[i] = loadImage( planetNames[i] + ".jpg");

      noStroke();
      fill(255);
      sphereDetail(40);

      planetShapes[i] = createShape(SPHERE, shapeY[i]);
      planetShapes[i].setTexture(planetMaps[i]);
    }
  }

  void make() {
    
        
        for (int i = 0; i < programState+1 ; i++) {
          pushMatrix();
          rotateY(PI * frameCount / rotationY[i]);
          translate(0, 0, translateZ[i]);
          shape(planetShapes[i]);
          popMatrix();
          
          pushMatrix();
          noFill();
          stroke(255);
          rotateX(PI/2);
          ellipse(0, 0, translateZ[i]*2, translateZ[i]*2);
          popMatrix();
        }
      
    
  }
  
  
}
