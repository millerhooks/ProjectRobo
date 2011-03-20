import processing.serial.*;
import processing.net.*;
import oscP5.*;
import netP5.*;

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
float shoulder_targ, elbow_targ, wrist_targ = 0.0f;
float shoulder_current = 0.0f;


Serial port;
Server server;
float limits = 180.0;
float damping = 1;
float shoulder, elbow, wrist, claw = 0;

String current_event = "<s90><e180><w0><c0>";
int input_mode = 0;
boolean active = true;

void setup() {
  // Setup the window, rendering
  size(640,480, P3D);
  background(0);
  
  // Setup networking, server
  //server = new Server(this, 5204);
  // Setup OSC listening on port 8000. We're using this instead of the server above.
  oscP5 = new OscP5(this,8000);
  
  // Setup communication with arduino
  port = new Serial(this, "/dev/tty.usbmodem621", 115200);
}


void draw() {
  drawOsc();
  // Used for the iPhone communication server.
  //loadClientStream();
  if (active) {
    switch(input_mode) {
      case 0:          // Input from network connection 
        println(current_event);
        
        port.write(current_event);
        active = false;
        break;
      case 1:
        // write the current X-position of the mouse to the serial port as
        // a single byte
        // port.write("<smouseX)
        break;
    }
  }
  delay(5);
}
