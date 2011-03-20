void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    float  val  = theOscMessage.get(0).floatValue();
    println (val);
    
    if(addr.equals("/1/fader1"))        { v_fader1 = val; }
    else if(addr.equals("/1/fader2"))   { v_fader2 = val; }
    else if(addr.equals("/1/fader3"))   { v_fader3 = val; }
    else if(addr.equals("/1/fader4"))   { v_fader4 = val; }
    else if(addr.equals("/1/fader5"))   { v_fader5 = val; }
    else if(addr.equals("/1/toggle1"))  { v_toggle1 = val; }
    else if(addr.equals("/1/toggle2"))  { v_toggle2 = val; }
    else if(addr.equals("/1/toggle3"))  { v_toggle3 = val; }
    else if(addr.equals("/1/toggle4"))  { v_toggle4 = val; }
    v_fader1 = val;
    println (addr);
    current_event = "<s"+int(v_fader1*limits)+"><e"+int(v_fader2*limits)+"><w"+int(v_fader3*limits)+"><c"+int(v_fader4*limits)+">";
    //current_event = "<s"+v_fader1+"><e"+int(v_fader2*limits)+"><w"+int(v_fader3*limits)+"><c"+int(v_fader4*limits)+">";

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
    rect(17,95 + 255 - v_fader1*255,60,v_fader1*255);
    rect(92,95 + 255 - v_fader2*255,60,v_fader2*255);
    rect(168,95 + 255 - v_fader3*255,60,v_fader3*255);
    rect(244,95 + 255 - v_fader4*255,60,v_fader4*255);
}
