import processing.serial.*;
import processing.net.*;

Serial port;
Server server;

int shoulder, elbow, wrist, claw = 0;

String current_event = "<s0><e0><w0><c0>";
int input_mode = 0;
boolean active = true;

void setup() {
  // Setup the window, rendering
  size(640,480, P3D);
  background(0);
  
  // Setup networking, server
  server = new Server(this, 5204);
  
  // Setup communication with arduino
  port = new Serial(this, "/dev/tty.usbmodem621", 9600);
}

void draw() {
  loadClientStream();
  if (active) {
    switch(input_mode) {
      case 0:          // Input from network connection 
        port.write(current_event);
        active = false;
        break;
      case 1:
        // write the current X-position of the mouse to the serial port as
        // a single byte
        port.write(mouseX);
        //println(mouseX);
        break;
    }
  }
}

