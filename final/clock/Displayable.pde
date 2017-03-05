class Displayable {
  
  float posA = 0.0;
  Planet p;
  int age = 0;
  boolean isDying = false;
  boolean isDead = false;
  
  Displayable(Planet p, float posA) {
    this.p = p;
    this.posA = posA;
  }
  
  void display() {    
    pushMatrix();
      rotate(posA);
      translate(p.halfsize, 0);
      pushMatrix();
        rotate(PI/2);
        grow();
      popMatrix();
    popMatrix();
  }
  
  void grow() {}
  
}