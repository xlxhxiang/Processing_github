import ddf.minim.*;

Minim minim;
AudioPlayer bgm;
PImage pic;

void setup() {
  size(600,400);
  pic=loadImage("bgm.jpg");
  background(pic);
  noStroke();
  colorMode(HSB,1);
  
  minim=new Minim(this);
  bgm=minim.loadFile("bgm.mp3");
}

void draw() {
  bgm.play();
  
  fill(pow(random(1),4),1,pow(random(1),2));
  ellipse(random(width),random(height),2,2);
  filter(BLUR);
  filter(DILATE); // also interesting if you reverse the filters...
}