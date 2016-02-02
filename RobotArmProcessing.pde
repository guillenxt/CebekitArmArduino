// Language: Processing
// RobotArmControl.pde

// by Sam Thongrong Feb 26, 2014

// load the serial library for Processing
import processing.serial.*;
// instance of the serial class
Serial port;

// control commands array:
// GripOut, GripIn, WristUp, WristDown, ElbowUp, ElbowDown,
// ShoulderUp, shoulderDown, BaseCW, BaseCCW, LightOn, LightOff, Stop

int[] controls = new int[] {
  0x47, 0x67, 0x57, 0x77, 0x45, 0x65,
  0x53, 0x73, 0x42, 0x62, 0x4c, 0x6c, 0x58 };
                  
// Image button.
// Loading images and using them to create a button.
ImageButtons GripIn;
ImageButtons GripOut;
ImageButtons WristUp;
ImageButtons WristDown;
ImageButtons ElbowUp;
ImageButtons ElbowDown;
ImageButtons ShoulderUp;
ImageButtons ShoulderDown;
ImageButtons BaseCW;
ImageButtons BaseCCW;
ImageButtons LightOn;
ImageButtons LightOff;
ImageButtons Pause;

// background
PImage bg;

// set the font
PFont myFont;

void controlGUI()
{
  bg = loadImage("background.jpg");
  background(bg);
 
  int buttonSize = 44;
 
  PImage selected = loadImage("controlSel.png");
 
  //Grip In
  PImage gripInImage = loadImage("controlIn.png");
  PImage gripInOver = loadImage("controlInOver.png");
  GripIn = new ImageButtons(330, 513, buttonSize, buttonSize,        //     30,83
                               gripInImage, gripInOver, selected);
                              
  //Grip Out
  PImage gripOutImage = loadImage("controlOut.png");
  PImage gripOutOver = loadImage("controlOutOver.png");
  GripOut = new ImageButtons(380, 513, buttonSize, buttonSize,
                               gripOutImage, gripOutOver, selected);
                              
  //Wrist Up
  PImage wristUpImage = loadImage("controlUp.png");
  PImage wristUpOver = loadImage("controlUpOver.png");
  WristUp = new ImageButtons(458, 146, buttonSize, buttonSize,
                               wristUpImage, wristUpOver, selected);
                              
  //Wrist Down
  PImage wristDownImage = loadImage("controlDown.png");
  PImage wristDownOver = loadImage("controlDownOver.png");
  WristDown = new ImageButtons(510, 146, buttonSize, buttonSize,
                               wristDownImage, wristDownOver, selected);

  //Elbow Up
  PImage elbowUpImage = loadImage("controlUp.png");
  PImage elbowUpOver = loadImage("controlUpOver.png");
  ElbowUp = new ImageButtons(840, 148, buttonSize, buttonSize,
                               elbowUpImage, elbowUpOver, selected);
                              
  //Elbow Down
  PImage elbowDownImage = loadImage("controlDown.png");
  PImage elbowDownOver = loadImage("controlDownOver.png");
  ElbowDown = new ImageButtons(888, 148, buttonSize, buttonSize,
                               elbowDownImage, elbowDownOver, selected);

  //Shoulder Up
  PImage shoulderUpImage = loadImage("controlUp.png");
  PImage shoulderUpOver = loadImage("controlUpOver.png");
  ShoulderUp = new ImageButtons(668, 440, buttonSize, buttonSize,  //700,440
                               shoulderUpImage, shoulderUpOver, selected);
                              
  //Shoulder Down
  PImage shoulderDownImage = loadImage("controlDown.png");
  PImage shoulderDownOver = loadImage("controlDownOver.png");
  ShoulderDown = new ImageButtons(712, 440, buttonSize, buttonSize,//650,440
                               shoulderDownImage, shoulderDownOver, selected);

  //Base CW
  PImage baseCWImage = loadImage("controlCW.png");
  PImage baseCWOver = loadImage("controlCWOver.png");
  BaseCW = new ImageButtons(730, 594, buttonSize, buttonSize,
                               baseCWImage, baseCWOver, selected);
                              
  //Base CCW
  PImage baseCCWImage = loadImage("controlCCW.png");
  PImage baseCCWOver = loadImage("controlCCWOver.png");
  BaseCCW = new ImageButtons(778, 594, buttonSize, buttonSize,
                               baseCCWImage, baseCCWOver, selected);
  //Light On
  PImage lightOnImage = loadImage("LightOn.png");
  PImage lightOnOver = loadImage("LightOnOver.png");
  LightOn = new ImageButtons(547, 517, buttonSize, buttonSize,
                               lightOnImage, lightOnOver, selected);
                              
  //Light Off
  PImage lightOffImage = loadImage("LightOff.png");
  PImage lightOffOver = loadImage("LightOffOver.png");
  LightOff = new ImageButtons(588, 517, buttonSize, buttonSize,  //78, 184
                               lightOffImage, lightOffOver, selected);

}

void setup()  {
  // List all the available serial ports in the output pane.
  // You will need to choose the port that the Arduino board is
  // connected to from this list. The first port in the list is
  // port #0 and the third port in the list is port #2.
  //println(Serial.list());
  // Open the port that the Arduino board is connected to
  // (in this case #0)
  // Make sure to open the port at the same speed Arduino is
  // using (112500bps)
  //port = new Serial(this, Serial.list()[1], 112500);
 
  // On Window PC, use "Outgoing" of the bluetooth device
  // This one for XBee
  port = new Serial(this, Serial.list()[2], 9600);  //115000 xbee/ COM30
 
  // screen size of the program
  //size(145, 455);
  size(1000, 700);  //400,300 pantalla
  smooth();
 
  // test ellipse
  ellipseMode(RADIUS);
  textFont(createFont("Verdana", 14));
   
  controlGUI();
 
}

void updateDisplay() {
 
  GripIn.update();
  GripIn.display();
  GripOut.update();
  GripOut.display();
 
  WristUp.update();
  WristUp.display();
  WristDown.update();
  WristDown.display();
 
  ElbowUp.update();
  ElbowUp.display();
  ElbowDown.update();
  ElbowDown.display();
 
  ShoulderUp.update();
  ShoulderUp.display();
  ShoulderDown.update();
  ShoulderDown.display();
 
  BaseCW.update();
  BaseCW.display();
  BaseCCW.update();
  BaseCCW.display();
 
  LightOn.update();
  LightOn.display();
  LightOff.update();
  LightOff.display();
}

//Send Commands
void sendCommands() {

  // Grip
  if(GripIn.pressed) {
      port.write(controls[0]);
      //println("Grip In: " + (char)controls[0]);
  }
  if(GripOut.pressed) {
      port.write(controls[1]);
      //println("Grip Out: " + (char)controls[1]);
  }
  if(mouseX > 330 && mouseX < 429 &&              //30, 129
     mouseY > 460 && mouseY < 510) {       //51, 79
       port.write(controls[12]);
       //println("Grip Stop! " + (char)controls[12]);
  }

  // Wrist
  if(WristUp.pressed) {
      port.write(controls[2]);
      //println("Wrist Up: " + (char)controls[2]);
  }
  if(WristDown.pressed) {
      port.write(controls[3]);
      //println("Wrist Down: " + (char)controls[3]);
  }
  if(mouseX > 458 && mouseX < 558 &&    //148 , 248
     mouseY > 105 && mouseY < 145) {       //5 , 33
       port.write(controls[12]);
       //println("Wrist Stop! " + (char)controls[12]);
  }
 
  // Elbow
  if(ElbowUp.pressed) {
      port.write(controls[4]);
      //println("Elbow Up: " + (char)controls[4]);
  }
  if(ElbowDown.pressed) {
      port.write(controls[5]);
      //println("Elbow Down: " + (char)controls[5]);
  }
  if(mouseX > 838 && mouseX < 930 &&     //258, 358
     mouseY > 110 && mouseY < 144) {       //51,79
       port.write(controls[12]);
       //println("Elbow Stop! " + (char)controls[12]);
  }
 
  //Shoulder
  if(ShoulderUp.pressed) {
      port.write(controls[6]);
      //println("Shoulder Up: " + (char)controls[6]);
  }  
  if(ShoulderDown.pressed) {
      port.write(controls[7]);
      //println("Shoulder Down: " + (char)controls[7]);
  }
  if(mouseX > 675 && mouseX < 748 &&  //208,308
     mouseY > 395 && mouseY < 439) {   //130, 158
       port.write(controls[12]);
       //println("Shoulder Stop! " + (char)controls[12]);
  }
 
  // Base
  if(BaseCW.pressed) {
      port.write(controls[8]);
      //println("Base Rotate CW: " + (char)controls[8]);
  }
  if(BaseCCW.pressed) {
      port.write(controls[9]);
      //println("Base Rotate CCW: " + (char)controls[9]);
  }
  if(mouseX > 680 && mouseX < 861 &&            //130    230
     mouseY > 553 && mouseY < 593) {            //202   230  
       port.write(controls[12]);
       //println("Base Stop! " + (char)controls[12]);
  }
 
  // Light
  if(LightOn.pressed) {
      port.write(controls[10]);
      //println("Light On: " + (char)controls[10]);
  }
  if(LightOff.pressed) {
      port.write(controls[11]);
      //println("Light Off: " + (char)controls[11]);
  }
}

void draw()
{
  updateDisplay();
 
  sendCommands();
}

// Button & ImageButtons Classes
class Button
{
  int x, y;
  int w, h;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;  
 
  void pressed() {
    if(over && mousePressed) {
      pressed = true;
    } else {
      pressed = false;
    }   
  }
 
  boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
}

class ImageButtons extends Button
{
  PImage base;
  PImage roll;
  PImage down;
  PImage currentimage;

  ImageButtons(int ix, int iy, int iw, int ih,
               PImage ibase, PImage iroll, PImage idown)
  {
    x = ix;
    y = iy;
    w = iw;
    h = ih;
    base = ibase;
    roll = iroll;
    down = idown;
    currentimage = base;
  }
 
  void update()
  {
    over();
    pressed();
    if(pressed) {
      currentimage = down;
    } else if (over){
      currentimage = roll;
    } else {
      currentimage = base;
    }
  }
 
  void over()
  {
    if( overRect(x, y, w, h) ) {
      over = true;
    } else {
      over = false;
    }
  }
 
  void display()
  {
    image(currentimage, x, y);
  }
}

// Processing End
