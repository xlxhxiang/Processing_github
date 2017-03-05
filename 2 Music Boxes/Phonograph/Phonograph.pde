import processing.video.*;

Movie movie;
PImage bg;
PImage posture;
PFont font;
boolean started= false;

void setup() {
  size(640, 480);
  bg=loadImage("background.png");
  posture=loadImage("posture.png");
  font=loadFont("BanglaMN-Bold-48.vlw");

  movie=new Movie(this, "Phonograph.mov");
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {

  background(bg);
  image(posture, 550, 400);

  textFont(font, 12);
  fill(255);
  text("press and hold on", 500, 450);


    image(movie, 0, 0, width, height);

}

void mousePressed(){
    movie.loop();
}

void mouseReleased() {
  movie.pause();
}