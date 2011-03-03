/** CAUTION: For your own safety, and to prevent damaging the motors, take the props off when testing code!!
* This sketch reads the charachters over serial and sets the speed of ESC accordingly. 
* the keys 'a' 's' 'd' 'f' are used to increase speed
* the keys 'h' 'j' 'k' 'l' are used to decrease speed of the four motors
* increment amount is between 1 and 5 and can be set buy the numbers 1 to 5
* For our ESC the angle is between 68 and 100. 68 and lower values map to no rotation of the motor.
*
* Author: Aras Balali Moghaddam
*
**/

#include <Servo.h>

Servo p1;
Servo p2;
Servo p3;
Servo p4;

int p1Speed = 0;
int p2Speed = 0;
int p3Speed = 0;
int p4Speed = 0;

int STEP = 5;

void arm(){
  // arm the speed controller by setting speed to 0 and delay for 1 second. 
  // Some speed controllers may need longer delay.
  setSpeed();
  delay(1000); 
}

void setSpeed(){
  p1.write(p1Speed);
  p2.write(p2Speed);
  p3.write(p3Speed);
  p4.write(p4Speed);
}

void setAllSpeedTo(int speed) {
  //set the speed for all four motors to "speed"
  p1Speed = speed;
  p2Speed = speed;
  p3Speed = speed;
  p4Speed = speed;
  Serial.print("Set all speed to: ");
  Serial.println(speed);
  
  //send new values to motors
  setSpeed();
}

void setup() {
  // initialize serial communication:
  Serial.begin(9600);
 
  //Attach servo motors to pins
  p1.attach(9);
  p2.attach(10);
  p3.attach(11);
  p4.attach(12);
  
  arm();
  setAllSpeedTo(68);
}

void loop() {
  // read the sensor:
  if (Serial.available() > 0) {
    int inByte = Serial.read();

    switch (inByte) {
    case 'a':    
      if(p1Speed < 100) p1Speed += STEP;
      Serial.println(p1Speed, DEC);
      break;
    case 's':    
      if(p2Speed < 100) p2Speed += STEP;
      Serial.println(p2Speed, DEC);
      break;
    case 'd':    
      if(p3Speed < 100) p3Speed += STEP;
      Serial.println(p3Speed, DEC);
      break;
    case 'f':    
      if(p4Speed < 100) p4Speed += STEP;
      Serial.println(p4Speed, DEC);
      break;
    case 'h':    
      if(p1Speed > 68) p1Speed -= STEP;
      Serial.println(p1Speed, DEC);
      break;
    case 'j':    
      if(p2Speed > 68) p2Speed -= STEP;
      Serial.println(p2Speed, DEC);
      break;
    case 'k':    
      if(p3Speed > 68) p3Speed -= STEP;
      Serial.println(p3Speed, DEC);
      break;
    case 'l':    
      if(p4Speed > 68) p4Speed -= STEP;
      Serial.println(p4Speed, DEC);
      break;
    case '1':
      STEP = 1;
      break;
    case '2':
      STEP = 2;
      break;
    case '3':
      STEP = 3;
      break;
    case '4':
      STEP = 4;
      break;
    case '5':
      STEP = 5;
      break;
    default:
      // turn all the motors off
      setAllSpeedTo(68);
    }
  }
  setSpeed();
}

