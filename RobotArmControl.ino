// Language: Arduino
// RobotArmControl.pde
//
// by Sam Thongrong Feb 26, 2012
// rev.02 
// control commands array:
// {GripOut, GripIn, WristUp, WristDown, ElbowUp, ElbowDown,
// ShoulderUp, shoulderDown, BaseCW, BaseCCW, LightOn, LightOff, Stop};
int controls[13] = { 0x47, 0x67, 0x57, 0x77, 0x45, 0x65, 
                   0x53, 0x73, 0x42, 0x62, 0x4c, 0x6c, 0x58 };

// Base
int baseEnablePin = 3;
int basePin1      = 2;
int basePin2      = 4;

// Shoulder Hombro
int shoulderEnablePin = 5;
int shoulderPin1      = 7;
int shoulderPin2      = 8;

// Elbow Codo
int elbowEnablePin = 6;
int elbowPin1      = 13;
int elbowPin2      = 14;

// Wrist Muñeca
int wristEnablePin = 9;
int wristPin1      = 15;
int wristPin2      = 16;

//Grip Pinza
int gripEnablePin = 10;
int gripPin1      = 11;
int gripPin2      = 12; 

int ledPin = 13;

// set a variable to store the byte sent from the serial port
int incomingByte;

void setup() {
  // set light LED 
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
  
  // set the SN754410 pins as outputs:
  pinMode(basePin1, OUTPUT);
  pinMode(basePin2, OUTPUT);
  pinMode(baseEnablePin, OUTPUT);
  
  pinMode(shoulderPin1, OUTPUT);
  pinMode(shoulderPin2, OUTPUT);
  pinMode(shoulderEnablePin, OUTPUT);
  
  pinMode(elbowPin1, OUTPUT);
  pinMode(elbowPin2, OUTPUT);
  pinMode(elbowEnablePin, OUTPUT);
  
  pinMode(wristPin1, OUTPUT);
  pinMode(wristPin2, OUTPUT);
  pinMode(wristEnablePin, OUTPUT);
  
  pinMode(gripPin1, OUTPUT);
  pinMode(gripPin2, OUTPUT);
  pinMode(gripEnablePin, OUTPUT);
  
  // start sending data at 115200 baud rate
  // I set my Xbee Baud Rate at 115200 bps,
  // change the Baud Rate according to your XBee
  Serial.begin(9600); //115200
}

void loop() {
    // check that there's something in the serial buffer
  if (Serial.available() > 0) {
    // read the byte and store it in our variable 
    // the byte sent is actually an ascii value
    incomingByte = Serial.read();
    // note the upper casing of each letter!
    // each letter turns a motor different way.
    
    //===== Grip
    // Grip in
    if (incomingByte == controls[0]) {
      gripIn();
    }
    // Grip Out
    if (incomingByte == controls[1]) {  
      gripOut();
    } 
    
    //Wrist
    if (incomingByte == controls[2]) {
    //digitalWrite(wristPin1, LOW);   
    //digitalWrite(wristPin2, HIGH);  
    wristUp();
    } 
    if (incomingByte == controls[3]) {    
      wristDown();
    }
    
    //===== Elbow
    // Elbow Up
    if (incomingByte == controls[4]) {
      elbowUp(); 
    }
    // Elbow Down
    if (incomingByte == controls[5]) {
      elbowDown();
    }
    
    //===== Shoulder
    // Shoulder Up
    if (incomingByte == controls[6]) {
      shoulderUp();
    }
    // Shoulder Down
    if (incomingByte == controls[7]) { 
      shoulderDown();
    }
    
    //===== Base
    // Base Right
    if (incomingByte == controls[8]) {
      baseRight();  
    }
    // Base Left
    if (incomingByte == controls[9]) {
      baseLeft();
    }

    // Light ON
    if (incomingByte == controls[10]) {
      digitalWrite(ledPin, HIGH);
    }
    // Light OFF
    if (incomingByte == controls[11]) {
      digitalWrite(ledPin, LOW);
    }
    
    // if a O is sent make sure the motors are turned off
    if (incomingByte == controls[12]) {
      allStop();
    }
    
    delay(100);
  }
}

void gripIn() {
    digitalWrite(gripEnablePin, HIGH);
    digitalWrite(gripPin1, LOW);
    digitalWrite(gripPin2, HIGH);
}

void gripOut() {
    digitalWrite(gripEnablePin, HIGH);
    digitalWrite(gripPin2, LOW);
    digitalWrite(gripPin1, HIGH);
}

void wristUp() {
    digitalWrite(wristEnablePin, HIGH);
    digitalWrite(wristPin1, LOW);
    digitalWrite(wristPin2, HIGH);
}

void wristDown() {
    digitalWrite(wristEnablePin, HIGH);
    digitalWrite(wristPin2, LOW);
    digitalWrite(wristPin1, HIGH);
}

void elbowUp() {
    digitalWrite(elbowEnablePin, HIGH);
    digitalWrite(elbowPin1, LOW);
    digitalWrite(elbowPin2, HIGH);
}

void elbowDown() {
    digitalWrite(elbowEnablePin, HIGH);
    digitalWrite(elbowPin2, LOW);
    digitalWrite(elbowPin1, HIGH);
}

void shoulderUp() {
    digitalWrite(shoulderEnablePin, HIGH);
    digitalWrite(shoulderPin1, LOW);
    digitalWrite(shoulderPin2, HIGH);
}

void shoulderDown() {
    digitalWrite(shoulderEnablePin, HIGH);
    digitalWrite(shoulderPin2, LOW);
    digitalWrite(shoulderPin1, HIGH);
}

void baseRight() {
    digitalWrite(baseEnablePin, HIGH);
    digitalWrite(basePin1, LOW);
    digitalWrite(basePin2, HIGH);
}

void baseLeft() {
    digitalWrite(baseEnablePin, HIGH);
    digitalWrite(basePin2, LOW);
    digitalWrite(basePin1, HIGH);
}

void allStop() {
    digitalWrite(baseEnablePin, LOW);
    digitalWrite(basePin1, LOW);   
    digitalWrite(basePin2, LOW);
    
    digitalWrite(shoulderEnablePin, LOW);
    digitalWrite(shoulderPin1, LOW);   
    digitalWrite(shoulderPin2, LOW); 
    
    digitalWrite(elbowEnablePin, LOW);
    digitalWrite(elbowPin1, LOW);   
    digitalWrite(elbowPin2, LOW);  
    
    digitalWrite(wristEnablePin, LOW);
    digitalWrite(wristPin1, LOW);   
    digitalWrite(wristPin2, LOW); 
    
    digitalWrite(gripEnablePin, LOW);
    digitalWrite(gripPin1, LOW);   
    digitalWrite(gripPin2, LOW); 
}
