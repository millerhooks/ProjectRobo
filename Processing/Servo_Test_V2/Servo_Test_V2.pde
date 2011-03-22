import processing.serial.*;
import processing.net.*;
import cc.arduino.*;

import oscP5.*;
import netP5.*;

boolean debug = true;

Arduino arduino;
OscP5 oscP5;

float v_fader1 = 0.0f;
float v_fader2 = 0.0f;
float v_fader3 = 0.0f;
float v_fader4 = 0.0f;
float v_fader5 = 0.0f;
float v_toggle1 = 0.0f;
float v_toggle2 = 0.0f;
float v_toggle3 = 0.0f;
float v_toggle4 = 0.0f;

HashMap servos = new HashMap();
float shoulder_current = 0.0f;

float limits = 180.0;
float damping = 1;
float shoulder, elbow, wrist, claw = 0;

String current_event = "<s90><e180><w0><c0>";

int arduino_comm_mode = 0;
boolean active = true;


void setup() {
  // Setup the window, rendering
  size(640,480, P3D);
  background(0);
  
  // Setup communication with arduino.
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  // Setup OSC listening on port 8000.
  oscP5   = new OscP5(this,8000);
  
  servos.put("shoulder", new ServoJoint("shoulder", 10));
  servos.put("elbow", new ServoJoint("elbow", 9));
  servos.put("wrist", new ServoJoint("wrist", 11));
}

void draw() {
  drawOsc();
  if (active) {
        //port.write(current_event);
        active = false;
  }
  delay(5);
}
