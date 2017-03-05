class Human {
  int age;
  int h;  // taille
  int x, y;

  Human( int xx, int yy, int hh) {
    age  = 0;
    h = hh;
    x = xx;
    y = yy;
  }

  void display() {
    age++;
    drawMan(x, y, h, map((age%11), 0, 11, -.5, .5));
    
  }

  void drawMan(int x, int y, float s, float ang) {
    noStroke();
    fill(0);
    float m = s/8; // mesure
    pushMatrix();
    translate(x, y);
    rotate(HALF_PI);
    translate(-.9*h+abs(ang)*1.5*m, 0);
    ellipse(0, 0, m*1.2, m*1.2); // head
    translate(m*.75, 0);
    rect( 0, m/4, 2.5*m, -m/2);
    // left arm
    arm(m, ang);
    // right arm
    arm(m, -ang);

    translate(2.5*m, 0);
    // left leg
    leg(m, ang);
    // right leg
    leg(m, -ang);

    popMatrix();
  }

  void arm(float m, float ang) {
    pushMatrix();
    rotate(.8*ang);
    rect( 0, m/4, 2*m, -m/2);
    translate(2*m, 0);
    rotate(-abs(ang)*2);
    rect( 0, m/4, 2*m, -m/2);
    popMatrix();
  }

  void leg(float m, float ang) {
    pushMatrix();
    rotate(-.05-1.2*ang);
    rect( 0, m/4, 2*m, -m/2);
    translate(2*m, 0);
    if (ang > 0) rotate(1.4*ang);
    if (ang < 0) rotate(-.2*ang);
    rect( 0, m/4, 2*m, -m/2);
    popMatrix();
  }

}