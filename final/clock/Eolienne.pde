class Eolienne extends Displayable {
  
  int h = 30;
  int w = 7;  // width of eolienne
  float a; // angle
  float aspeed = PI/20; // angular speed
  
  Eolienne(Planet p, float posA) {
    super(p, posA);
    h = p.halfsize>>2;
  }
  
  void grow() {
    
    if ( isDying ) {
      age--;
    } else {
    age++;
    }
    
    int gh = h;
    int gh2 = h/2;

    if (age < 40) {
      if (age < 0) isDead = true;
      if (age < 10) gh = min(age, 10)*h/10;
      gh2 = 0;
      if (age > 20) gh2 = (min(age, 30)-20)*h/20;
    } else {
      age = 40;
      a += aspeed;
      if (a > TWO_PI) a -= TWO_PI;
    }
    stroke(0);
    triangle(-w/2, 0, w/2, 0, 0, -gh);
    if (age > 10) {  
      pushMatrix();
        translate(0, -gh);
          for (int i = 0; i < 3; i++) {
          pushMatrix();
            rotate(a + TWO_PI*i/3);
            triangle(-w/2, 0, w/3, 0, 0, -gh2);
          popMatrix();
        }
      popMatrix();
    }
    
  }
  
}