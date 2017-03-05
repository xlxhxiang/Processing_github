int xCentre = 300;
int yCentre = 200;
int hourHand = 40;   // length of hour  hand
int minHand = 70;   // length of minute  hand
int secHand = 110;   // length of second hand
int digClockRow = 280;  //  Row of Digital Clock
float endX, endY;
int zone=1;

PImage bgImage;
PFont font;
PShape rect1;
PShape rect2;
PShape rect3;
PShape rect4;
PShape clockface;

void setup() {

  size(600, 400);
  bgImage=loadImage("background.jpg");
  background(bgImage);
  font=loadFont("AtomicClockRadio-48.vlw");
  
  rect1= createShape(RECT, 0, 0, 150, 400);
  rect1.setFill(color(108, 181, 172));
  rect1.setStroke(false);
  rect2= createShape(RECT, 150, 0, 150, 400);
  rect2.setFill(color(236, 227, 170));
  rect2.setStroke(false);
  rect3= createShape(RECT, 300, 0, 150, 400);
  rect3.setFill(color(166, 199, 144));
  rect3.setStroke(false);
  rect4= createShape(RECT, 450, 0, 150, 400);
  rect4.setFill(color(221, 96, 100));
  rect4.setStroke(false);
  
  
  clockface= createShape(ELLIPSE, 300, 200, 250, 250);
  clockface.setFill(color(221, 221, 221));
  clockface.setStroke(false);

}


void draw() {

  shape(rect1);
  shape(rect2);
  shape(rect3);
  shape(rect4);
  
  //text
  textFont(font, 18);
  fill(255);
  text("BJ", 214, 102);
  text("CHINA", 196, 129);
  textFont(font, 18);
  fill(255);
  text("SF", 64, 102);
  text("USA", 58, 129);
  textFont(font, 18);
  fill(255);
  text("TK", 364, 102);
  text("JAPAN", 345, 129);
  fill(255);
  textFont(font, 18);
  fill(255);
  text("PR", 514, 102);
  text("FRANCE", 490, 129);
  fill(255);


  shape(clockface);
  

  float  hour12 = hour();
  if (zone ==1) hour12 = hour();
  if (zone ==2) hour12 = hour()+16;
  if (zone ==3) hour12 = hour()+17;
  if (zone ==4) hour12 = hour()+9;
  if (hour12 > 12) {
    hour12 -= 12;
  }
  // the hour hand needs to be advanced in proportion to how many minutes have elapsed
  hour12 += minute() / 60.0;
  endX = xCentre + hourHand * sin(radians(map(hour12, 0, 12, 0, 360)));
  endY = yCentre - hourHand * cos(radians(map(hour12, 0, 12, 0, 360)));
  stroke(255, 214, 171);  // wood
  strokeWeight(3);
  smooth();
  line(xCentre, yCentre, endX, endY);

  // draw the minute hand - location adjusted by the seconds
  float minuteAmt = minute();
  minuteAmt += second() / 60.0;
  endX = xCentre + minHand * sin(radians(map(minuteAmt, 0, 60, 0, 360)));
  endY = yCentre - minHand * cos(radians(map(minuteAmt, 0, 60, 0, 360)));
  stroke(255, 214, 171);  // wood
  strokeWeight(3);
  smooth();
  line(xCentre, yCentre, endX, endY);

  // draw the second hand
  float MSeconds;
  MSeconds = second() ;
  endX = xCentre + secHand * sin(radians(map(MSeconds, 0, 60, 0, 360)));
  endY = yCentre - secHand * cos(radians(map(MSeconds, 0, 60, 0, 360)));
  stroke(255, 214, 171); //wood
  strokeWeight(3);
  smooth();
  line(xCentre, yCentre, endX, endY);
}

void mousePressed() {
  if (mouseX<150 && mouseY<height) {
    zone=1;
    image(clockface1, 175, 75);
    rect1.scale(1.8,0);
    rect2.scale(0.3,0);
    rect3.scale(0.3,0);
    rect4.scale(0.3,0);
  } else if (mouseX>150 && mouseX<300) {
    zone=2;
    rect1.scale(0.3,0);
    rect2.scale(1.8,0);
    rect3.scale(0.3,0);
    rect4.scale(0.3,0);
  } else if (mouseX>300 && mouseX<450 ) {
    zone=3;
    rect1.scale(0.3,0);
    rect2.scale(0.3,0);
    rect3.scale(1.8,0);
    rect4.scale(0.3,0);
  } else if (mouseX>450 && mouseX<width) {
    zone=4;
    rect1.scale(0.3,0);
    rect2.scale(0.3,0);
    rect3.scale(0.3,0);
    rect4.scale(1.8,0);
  }
}