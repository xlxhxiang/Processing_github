import gifAnimation.*;
import ddf.minim.*;


Minim minim;
AudioPlayer bgm;
Animation animation;



void setup() {

  size(600, 340);
  background(255);
  frameRate(20);

  minim=new Minim(this);
  bgm=minim.loadFile("bgm.mov");

  animation=new Animation("A_", 197);
}

void draw() {
  animation.display();
  bgm.play();
}

class Animation {
  PImage[] images;
  int imageCount;
  int frame;

  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + nf(i, 4) + ".png";
      images[i] = loadImage(filename);
    }
  }

  void display() {
    frame = (frame+1) % imageCount;
    image(images[frame], 0, 0);
  }


}