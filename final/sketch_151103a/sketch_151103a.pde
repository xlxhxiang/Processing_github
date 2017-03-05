import processing.opengl.*;

import krister.Ess.*;


FFT myfft;
AudioInput myinput;
PFont font;
int bufferSize=512;


int wh = 700;
int ww = 900;
int i = 1;


class Ball {
  float x, y, r, m;
  int col;

  // default constructor
  Ball() {
  }

  Ball(float x, float y, float r, int col) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.col = col;
    m = r*.1;
  }
}

Ball[] balls =  {
  new Ball(ww/2, wh/2, 80, 255), 
};



void setup() {
  fullScreen();
  //size(900, 700, OPENGL);
  frameRate(45);
  background(255);
  noStroke();
  smooth();

  font=loadFont("AkzidenzGroteskBQ-Super-48.vlw");

  Ess.start(this);
  myinput=new AudioInput(bufferSize);
  myfft=new FFT(bufferSize*2);
  myinput.start();

  myfft.damp(.5);
  myfft.equalizer(true);
  myfft.limits(.005, .01);
}

void draw() {
  background(0);   
  for (int i = 0; i < balls.length; i++) {
    if(myfft.averages[0]<0.1){
    fill(0, 255, random(0, 255));
    }
    if(myfft.averages[0]>0.1){
    fill(random(0,255),0,0);
    }
    ellipse(balls[i].x, balls[i].y, balls[i].r+myfft.averages[0]*800, balls[i].r+myfft.averages[0]*800);
  }
  if (myfft.averages[0] > 0.3) {
    Ball b = new Ball(random(ww), random(wh), random(80), (int)random(255));
    balls = (Ball[]) append(balls, b);
  }
  if (myfft.averages[0]>0.5) {
    textFont(font, 48);
    fill(0);
    text("HELP ME", ww/2-100, wh/2);
  }
}

public void audioInputData(AudioInput theInput) {
  myfft.getSpectrum(myinput);
}