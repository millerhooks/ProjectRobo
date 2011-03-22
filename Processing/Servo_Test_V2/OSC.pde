void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    float  val  = theOscMessage.get(0).floatValue()*limits;
    
    if(false && addr.equals("/body/rightHand"))        {
      v_fader1 = theOscMessage.get(0).floatValue();
      v_fader2 = theOscMessage.get(1).floatValue();
     // v_fader3 = theOscMessage.get(2).floatValue();
    }
    else if(addr.equals("/1/fader1"))   { ((ServoJoint)servos.get("shoulder")).current_pos = val; v_fader1 = val; }
    //else if(addr.equals("/1/fader2"))   { elbow_targ = val; v_fader2 = val; }
    //else if(addr.equals("/1/fader3"))   { wrist_targ = val; v_fader3 = val; }
    else if(addr.equals("/1/fader4"))   { v_fader4 = val; }
    else if(addr.equals("/1/fader5"))   { v_fader5 = val; }
    else if(addr.equals("/1/toggle1") || addr.equals("/ready"))  { 
      v_fader1 = 70;
      v_fader2 = 170;
      v_fader3 = 100;
    }
    else if(addr.equals("/1/toggle2") || addr.equals("/throw"))  { 
      v_fader1 = theOscMessage.get(2).floatValue();
      v_fader2 = theOscMessage.get(0).floatValue();
      v_fader3 = theOscMessage.get(1).floatValue();
    }
    else if(addr.equals("/1/toggle3"))  { v_toggle3 = val; }
    else if(addr.equals("/1/toggle4"))  { v_toggle4 = val; }

    if (debug) {
      println (addr);
      println ("x: "+v_fader1);
      println("y: "+v_fader2);    
      println("z: "+v_fader3);
    }
    /*
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
//    current_event = "<s"+int(v_fader1*limits)+"><e"+int(v_fader2*limits)+"><w"+int(v_fader3*limits)+"><c"+int(v_fader4*limits)+">";
  active = true;
  */
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
    rect(17,21,v_fader5*287,55);
    if(v_toggle1 == 1.0f) rect(22,374,50,40);
    if(v_toggle2 == 1.0f) rect(97,374,50,40);
    if(v_toggle3 == 1.0f) rect(173,374,50,40);
    if(v_toggle4 == 1.0f) rect(249,374,50,40);
    
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
