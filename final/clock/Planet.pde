class Planet {

  int x, y;                     // center of the planet 
  float a = 0.0;                // angle of the planet
  final float speed = -PI/500;  // angle speed
  int halfsize;                 // radius of the sphere
  ArrayList displayables;       // all the elements populating the planet
  float bornA = PI/5;           // angle where elements are generated
  float dieA = 4*bornA;         // angle where elements are deleted

  Planet(int x, int y, int h) {
    this.x = x;
    this.y = y;
    this.halfsize = h;
    displayables = new ArrayList();
  }

  // rotate the planet
  void turn() {
    a += speed;
    if (a > TWO_PI) a -= TWO_PI;

    // check for end of life elements
    for (int i=0; i < displayables.size(); i++) {
      Displayable d = (Displayable)displayables.get(i);

      // Checks if it's alive and passing the dying point
      if( (d.posA < -a-( dieA + d.age*speed ) ) && !(d.isDying) ){
        d.isDying = true;
      }

      // if dead remove it
      if (d.isDead) displayables.remove(i);
    }

  }

  // add an element
  void addObject(Displayable d) {
    displayables.add(d);  // method of the ArrayList
  }

  // clear the planet
  void clean() {
    displayables.clear();
  }

  // draw the whole planet to the window  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(a);
    stroke(0); 
    fill(0);

    // draw elements 
    for (int i=0; i < displayables.size(); i++) {
      Displayable d = (Displayable)displayables.get(i);
      d.display();
    }

    // draw ground
    ellipse(0, 0, halfsize<<1, halfsize<<1); // 1 left bit shifting = *2
    popMatrix();
  }

  void generate() {
    float n = frameCount*0.05;
    if (frameCount%(40*noise(n)) < 1 ) {
      // add an element
      switch ( int(noise(n*0.5)*4) ) {
      case 0:
        planet.addObject(new Building(planet, -planet.a-bornA));
        break;
      case 1:
        planet.addObject(new Cloud(planet, -planet.a-bornA));
        break;
      case 2:
        planet.addObject(new Tree2(planet, -planet.a-bornA));
        break;
      case 3:
        planet.addObject(new Eolienne(planet, -planet.a-bornA ));
        break;    
      }
    }
  }

}