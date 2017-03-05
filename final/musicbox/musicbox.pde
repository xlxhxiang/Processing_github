import ddf.minim.*;  

Minim minim;
AudioPlayer player;

int waveH = 300; 
int fluctuationDepth = 100; 
float noiseSeed;
float rotateSeed;
float rotateSpeed = 0.3;
int alpha = 7;
float colorTransion = 0.5;
float initRadius =25;

void setup()
{
  size(854, 480);
  colorMode(HSB, 360, 100, 100, 255);
  background(#000000);
  minim = new Minim(this);
  player = minim.loadFile("Bamboo.mp3", 1024);
  player.loop();
}

void draw()
{
  scrRefresh();
  noiseSeed += 0.01;

  translate(width/2, height/2);
  rotateSeed += noise(noiseSeed);
  rotate(radians(rotateSeed*rotateSpeed));
  pushMatrix();
  float xnoise = fluctuationDepth*(noise(noiseSeed)-0.5);
  float ynoise = fluctuationDepth*(noise(noiseSeed)-0.5);    
  translate(xnoise-player.left.size()/2, ynoise);
  for (int i=0; i< player.left.size()-1; i+=random(10,40)) {
    noStroke();
    fill((frameCount*colorTransion+80*(1-abs(player.mix.get(i)))-20)%360, 100, 70, 255);
    float radius = random(0, 10)+initRadius*player.mix.get(i);
    ellipse(i, player.left.get(i)*waveH, radius, radius);
  }
  popMatrix();
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}

void scrRefresh() {
  fill(0, 0, 0, alpha);
  noStroke();
  rect(0, 0, width, height);
}