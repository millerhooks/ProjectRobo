

class Vector {
  float x, y, z = 0;
  Vector(float iX, float iY, float iZ) {
    x = iX;
    y = iY;
    x = iX;
  }
  
  void printVector() {
    println("x: "+x+" y: "+y+" z: "+z);
  }  
}

Vector subtractVector(Vector v1, Vector v2) {
  Vector n = new Vector(0, 0, 0);
  n.x = v1.x - v2.x;
  n.y = v1.y - v2.y;
  n.z = v1.z - v2.z;
  return n;
}

void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    float  val  = theOscMessage.get(0).floatValue()*limits;
    
    // A hashmap is the right way to do this.
    body.put(addr, new Vector(theOscMessage.get(0).floatValue(), theOscMessage.get(1).floatValue(), theOscMessage.get(2).floatValue()));
    
    if(addr.equals("/body/leftHand"))        {
      left_hand.x = theOscMessage.get(0).floatValue();
      left_hand.y = theOscMessage.get(1).floatValue();
      left_hand.z = theOscMessage.get(2).floatValue();
      
      v_fader1 = theOscMessage.get(0).floatValue();
      v_fader2 = theOscMessage.get(1).floatValue();
      v_fader3 = theOscMessage.get(2).floatValue();
    }
    else if(addr.equals("/body/head"))        {
      head.x = theOscMessage.get(0).floatValue();
      head.y = theOscMessage.get(1).floatValue();
      head.z = theOscMessage.get(2).floatValue();
      
      v_fader1 = theOscMessage.get(0).floatValue();
      v_fader2 = theOscMessage.get(1).floatValue();
      v_fader3 = theOscMessage.get(2).floatValue();
    }
    else if(addr.equals("/1/toggle1") || addr.equals("/ready"))  { 
      v_fader1 = 70;
      v_fader2 = 170;
      v_fader3 = 100;
    }
    if (debug) {
      println (addr);
      println ("x: "+v_fader1);
      println("y: "+v_fader2);    
      println("z: "+v_fader3);
    }
    /* Smoothing...
    if (false) {
      if (shoulder > v_fader1) {
        shoulder = shoulder + ((v_fader1 - shoulder) / damping);
      } else {
        shoulder = shoulder - ((shoulder - v_fader1) / damping);
      }
      
      if (elbow > v_fader2) {
        elbow = elbow + ((v_fader2 - elbow) / damping);
      } else {
        elbow = elbow - ((elbow - v_fader2) / damping);
      }
      
      if (wrist > v_fader3) {
        wrist = wrist + ((v_fader3 - wrist) / damping);
      } else {
        wrist = wrist - ((wrist - v_fader3) / damping);
      }
      current_event = "<s"+int(shoulder)+"><e"+int(elbow)+"><w"+int(wrist)+"><c"+int(v_fader4*limits)+">";
      
    }
    else {
      //sendMessage(v_fader1, v_fader2, v_fader3, claw);
      
      
     current_event = "<s"+int(v_fader1)+"><e"+int(v_fader2)+"><w"+int(v_fader3)+"><c"+int(v_fader4*limits)+">";   
    }
    */
    Vector n = subtractVector(head, left_hand);
      n.printVector();
      current_event = "<s"+int(abs((n.x/700.0)*180-180))+"><e"+int(abs((n.y/1100.0)*180-180))+"><w"+int((n.z/500.0)*180)+"><c"+int(v_fader4*limits)+">";
    
  active = true;
}

void drawOsc() {
   // fader5 + toggle 1-4 outlines
    fill(0);
    stroke(0, 196, 168);  
    
    rect(17,21,287,55);
    rect(17,369,60,50);
    rect(92,369,60,50);
    rect(168,369,60,50);
    rect(244,369,60,50);

    // fader5 + toggle 1-4 fills
    fill(0, 196, 168);
    if(v_toggle1 == 1.0f) rect(22,374,50,40);
    if(v_toggle2 == 1.0f) rect(97,374,50,40);
    
    // fader 1-4 outlines
    fill(0);
    stroke(255, 237, 0);
    rect(17,95,60,255);
    rect(92,95,60,255);
    rect(168,95,60,255);
    rect(244,95,60,255);
    
    // fader 1-4 fills
    fill(255, 237, 0);
    rect(17,95 + 255 - v_fader1*255,60,v_fader1);
    rect(92,95 + 255 - v_fader2*255,60,v_fader2);
    rect(168,95 + 255 - v_fader3*255,60,v_fader3);
    rect(244,95 + 255 - v_fader4*255,60,v_fader4);
}
