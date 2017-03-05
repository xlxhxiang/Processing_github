/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4707*@* */


Planet planet;
Human hum;

boolean auto = true;

float sixty = TAU/60;
float twelve = TAU/12;
float pioffset = (TAU/4)*3;

float secondsBandSize = 500;
float minutesBandSize = 350;
float hoursBandSize = 200;

float secondsTextOffset = (minutesBandSize/2) + ((((secondsBandSize/2) - (minutesBandSize/2))) / 2);
float minutesTextOffset = (hoursBandSize/2) + ((((minutesBandSize/2) - (hoursBandSize/2))) / 2);
float hoursTextOffset = ((hoursBandSize/2) - (width/2)) / 2;

boolean showCompleteArc = true;

int strokeWidthAdd = 0;

int invert = 1;

int FPS = 60;

int minuteGlowFade = 0;
int hourGlowFade = 0;

void setup() {
  
  size(900,600);
  frameRate(20);
  smooth();
  strokeWeight(5);
  rectMode(CENTER);
  strokeCap(SQUARE);
  
  planet = new Planet(360, 500, 320);
  hum = new Human(planet.x, planet.y-planet.halfsize, planet.halfsize/8 );
  println("hum: "  + planet.x + " ," + (planet.y-planet.halfsize) );
  
  // Button setup
  int w2 = width/2;
  int h2 = height-55;
  
}

void draw() {
  
  planet.turn();
 
  // draw to the screen
  background(255);
  planet.display(); 
  hum.display();
  
  if (auto) planet.generate();
  
  float seconds = (sixty * second()) + pioffset;
  float minutes = (sixty * minute()) + pioffset;
  float hours = (twelve * (hour() % 12)) + pioffset;
  
  float secondsOffset = pioffset;
  float minutesOffset = pioffset;
  float hoursOffset = pioffset;
  
  if (!showCompleteArc)
  {
    secondsOffset += (sixty * (second() - 1));
    minutesOffset += (sixty * (minute() - 1));
    hoursOffset += (twelve * ((hour()-1) % 12));
  }
  
  // seconds
  stroke(#27ae60);
  
  arc(360, 480, secondsBandSize, secondsBandSize, secondsOffset, seconds);
  
  colorMode(RGB);
  
  //minutes
  stroke(#2980b9);
  
  if (second() < 1)
  {
    if (minuteGlowFade == FPS)
    {
      minuteGlowFade = 0;  
    }
    colorMode(HSB, 2*PI, 100, 100);
    
    float highlight = (27.5) - ((27.5 / FPS) * minuteGlowFade);
    stroke(radians(204), 77.8, 72.5 + highlight);
    minuteGlowFade++;
  }
   
  arc(360, 480, minutesBandSize, minutesBandSize, minutesOffset, minutes);
  
  colorMode(RGB);
  
  //hours
  stroke(#8e44ad);
  
  if (minute() < 1 && second() < 1)
  {
    if (hourGlowFade == FPS)
    {
      hourGlowFade = 0;  
    }
    colorMode(HSB, 2*PI, 100, 100);
    
    float hourHighlight = (32) - ((32.0 / FPS) * hourGlowFade);
    
    stroke(radians(282), 61, 68 + hourHighlight);
    hourGlowFade++;
  }
  
  arc(360, 480, hoursBandSize, hoursBandSize, hoursOffset, hours);
  
  colorMode(RGB);
  
  textAlign(CENTER);
  
  fill(#8e44ad, 127);
  text(hour(), 430, 470);
  
  fill(#2980b9, 127);
  text(minute(), 510, 470);
  
  fill(#27ae60, 127);
  text(second(), 590, 470);
  
  
}

void keyPressed() {
  if (key == 'b') {
    planet.addObject(new Building(planet, -planet.a-planet.bornA));
    auto = false;
  }
  if (key == 'c') {
    planet.addObject(new Cloud(planet, -planet.a-planet.bornA));
    auto = false;
  }
  if (key == 't') {
    planet.addObject(new Tree2(planet, -planet.a-planet.bornA));
    auto = false;
  }
  if (key == 'w') {
    planet.addObject(new Eolienne(planet, -planet.a-planet.bornA));
    auto = false;
  }
  if (key == ' ') {
    auto = true;
  }
}