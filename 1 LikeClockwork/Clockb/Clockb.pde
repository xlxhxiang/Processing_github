
PImage bgImage;
PImage clockface1;
PImage clockface2;
PImage clockface3;
PImage clockface4;

int xCentre = 300;
int yCentre = 200;
int hourHand = 40;   // length of hour  hand
int minHand = 70;   // length of minute  hand
int secHand = 110;   // length of second hand
int digClockRow = 280;  //  Row of Digital Clock
float endX, endY;
int zone = 0;

void setup() {

  size(600, 400);

  clockface1=loadImage("1.png");
  clockface2=loadImage("2.png");
  clockface3=loadImage("3.png");
  clockface4=loadImage("4.png");
  
    bgImage=loadImage("bgImage.jpg");
  background(bgImage);
}

void draw() {
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
  if(zone==0){
  noStroke();}
  line(xCentre, yCentre, endX, endY);

  // draw the minute hand - location adjusted by the seconds
  float minuteAmt = minute();
  minuteAmt += second() / 60.0;
  endX = xCentre + minHand * sin(radians(map(minuteAmt, 0, 60, 0, 360)));
  endY = yCentre - minHand * cos(radians(map(minuteAmt, 0, 60, 0, 360)));
  stroke(255, 214, 171);  // wood
  strokeWeight(3);
  smooth();
    if(zone==0){
  noStroke();}
  line(xCentre, yCentre, endX, endY);

  // draw the second hand
  float MSeconds;
  MSeconds = second() ;
  endX = xCentre + secHand * sin(radians(map(MSeconds, 0, 60, 0, 360)));
  endY = yCentre - secHand * cos(radians(map(MSeconds, 0, 60, 0, 360)));
  stroke(255, 214, 171); //wood
  strokeWeight(3);
  smooth();
    if(zone==0){
  noStroke();}
  line(xCentre, yCentre, endX, endY);
}

void mousePressed() {
  if (mouseX<150 && mouseY<height) {


    fill(221, 221, 221);
    stroke(255);
    ellipse(300, 200, 250, 250);
    image(clockface1, 175, 75);

    zone=1;
  } else if (mouseX>150 && mouseX<300 && mouseY<height) {
    fill(221, 221, 221);
    stroke(255);
    ellipse(300, 200, 250, 250);
    image(clockface2, 176, 75);

    zone=2;
  } else if (mouseX>300 && mouseX<450 && mouseY<height) {
    fill(221, 221, 221);
    stroke(255);
    ellipse(300, 200, 250, 250);
    image(clockface3, 175, 75);

    zone=3;
  } else if (mouseX>450 && mouseX<width && mouseY<height) {
    fill(221, 221, 221);
    stroke(255);
    ellipse(300, 200, 250, 250);
    image(clockface4, 180, 75);

    zone=4;
  }
}