class Tree2 extends Displayable {
  
  int h;
  float thick =1;
  float theta = .5;

  Tree2(Planet p, float posA) {
    super(p, posA);
    h = int(random(p.halfsize>>5, p.halfsize/6));
    theta = random(.1, .8);

  }

  void grow() {

    if ( isDying ) {
      age--;
    } 
    else {
      age++;
    }

    if (age < 0) isDead = true;
    if (age > 60) age = 60;

    int gh = min(age, h);



    noStroke();
    fill(0);
    thick = max(gh/6, 1.0f); 
    drawBranch(thick, gh);
    translate(0, -gh);
    branch(gh, theta);

  }

  void branch(float hi, float theta) {
    hi *= 0.6f;

    thick = max(hi/6, 1.0f); 
    // All recursive functions must have an exit condition!!!!
    // Here, ours is when the length of the branch is 2 pixels or less
    if (hi > 2) {

      pushMatrix();    // Save the current state of transformation (i.e. where are we now)
      rotate(theta);   // Rotate by theta
      drawBranch(thick, int(hi));  // Draw the branch
      translate(0,-hi); // Move to the end of the branch
      branch(hi, theta);       // Ok, now call myself to draw two new branches!!
      popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state



      thick = max(hi/6, 1.0f);   
      // Repeat the same thing, only branch off to the "left" this time!
      pushMatrix();
      rotate(-theta);
      drawBranch(thick, int(hi));
      translate(0,-hi);
      branch(hi, theta);
      popMatrix();

    }
  }

}

void drawBranch(float t, int h){
  beginShape();
  vertex(-t, 1);
  vertex( t, 1);
  vertex( t*.5, -h);
  vertex(-t*.5, -h);
  endShape(CLOSE);
};