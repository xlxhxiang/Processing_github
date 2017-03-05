class Cloud extends Displayable {
  
  int h;
  int thick;
  PVector balls[]; // n balls
  float wind = .003; // wind
  
  Cloud(Planet p, float posA){
    super(p, posA);
    h = int(random(p.halfsize>>2, p.halfsize>>1));
    thick = h/5;
    balls = new PVector[int(random(6))+3];
    for (int i =0; i < balls.length; i++){
      balls[i] = new PVector(random(1.2), random(1.0));
    }
    
    wind = random(-.003, .003);
    
  }
  
  void grow() {
    
    if ( isDying ) {
      age--;
    } 
    else {
      age++;
      posA -= wind;
    }
    
    if (age < 0) isDead = true;
    if (age > h ) age = h;
    
    int gh = min (age*3, h);
    int n = thick*gh/h;
    
    
    fill(0);
    pushMatrix();
    translate(0 , -gh);
    for (int i =0; i < balls.length; i++){
      fill(0);
      ellipse(balls[i].x*n,balls[i].y*n/2, n, n);
    }
    
    for (int i =0; i < balls.length; i++){
      noStroke();
      fill(255);
      ellipse(balls[i].x*n,balls[i].y*n/2, n-2, n-2);
    }
    fill(0);
    popMatrix();
  }

}