class Planet {
  PShape mercury, venus, earth, mars, jupiter, saturn, uranus, neptune;
  PShape[] planetShapes = {mercury, venus, earth, mars, jupiter, saturn, uranus, neptune};
  PImage mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap;
  PImage[] planetMaps = {mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap};
  String[] planetNames = { "mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"};
  float[] shapeY = {10, 30, 40, 30, 50, 30, 50, 20};
  float[] rotationY = {100, 50, 80, 100, 50, 40, 80, 100};
  float posMe = 200;
  float posVe = posMe+50;
  float posEa = posVe + 70;
  float posMa = posEa + 80;
  float posJu = posMa + 110;
  float posSa = posJu + 150;
  float posUr = posSa + 70;
  float posNe = posUr + 100;
  float[] translateZ = {posMe, posVe, posEa, posMa, posJu, posSa, posUr, posNe};

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
  
  void update() {
  for (int i = 0; i < programState+1 ; i++) {
    pot = translateZ[programState];
    press = shapeY[programState];
    flex = rotationY[programState];
  }
  
  }
  
  
}
