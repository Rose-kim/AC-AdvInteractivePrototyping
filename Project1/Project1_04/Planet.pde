class Planet {
  PShape sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune;
  PShape[] planetShapes = {sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune};
  PImage sunmap, mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap;
  PImage[] planetMaps = {sunmap, mercurymap, venusmap, earthmap, marsmap, jupitermap, saturnmap, uranusmap, neptunemap};
  String[] planetNames = { "mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"};
  int[] shapeY = {10, 30, 40, 30, 100, 100, 50, 50};
  int[] rotationY = {100, 50, 80, 100, 50, 40, 80, 100};
  int[] translateZ = {200, 250, 320, 400, 450, 660, 650, 750};


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
    for (int i = 0; i< planetNames.length; i++) {
      if (programState == i) {
        for (int j = 0; j < i+1 ; j++) {
          pushMatrix();
          rotateY(PI * frameCount / rotationY[j]);
          translate(0, 0, translateZ[j]);
          shape(planetShapes[j]);
          popMatrix();
        }
      }
    }
  }
}
