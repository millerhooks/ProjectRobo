
#include <Servo.h>

Servo shoulder, elbow, wrist, claw;  // create servo object to control a servo
                             // a maximum of eight servo objects can be created

int shoulder_pin  = 10;
int elbow_pin     = 9;
int wrist_pin     = 11;
int claw_pin      = 6;

int incomingByte   = 0;        // for incoming serial data

char buff[4];
byte i = 0;
boolean started = false;
boolean ended = false;
int value = 0;

void setup()
{
   shoulder.attach(shoulder_pin);  // attaches the servo on pin 9 to the servo object
   elbow.attach(elbow_pin);
   wrist.attach(wrist_pin);
   claw.attach(claw_pin);
   
   shoulder.write(incomingByte);
   elbow.write(incomingByte);
   wrist.write(incomingByte);
   claw.write(incomingByte);
   Serial.begin(115200);   // opens serial port, sets data rate to 9600 bps
}


void loop()
{
  while(Serial.available() > 0) {
    char aChar = Serial.read();
    Serial.print(aChar);
    if(aChar == '<'){
      started = true;
      ended = false;
    }
    else if(aChar == '>'){
      ended = true;
      break; // break the while loop
    }
    else {
      buff[i] = aChar;
      i++;
      buff[i] = '\0'; // this terminates the array
    }
  }

  if(started && ended){
    int intpos;
    char pos[3] = { buff[1], buff[2], buff[3] };
    intpos = atoi(pos);
/*    
    Serial.print("Writing motor ");
    Serial.print(buff[0]);
    Serial.print(" to ");
    Serial.println(intpos);
    Serial.println();
  */  
    if(buff[0] == 's') shoulder.write(intpos);
    if(buff[0] == 'e') elbow.write(intpos);
    if(buff[0] == 'w') wrist.write(intpos);
    if(buff[0] == 'c') claw.write(intpos);
    
    i = 0;
    buff[i] = '\0'; // this terminates the array
    started = false;
    ended = false;
  }

}
