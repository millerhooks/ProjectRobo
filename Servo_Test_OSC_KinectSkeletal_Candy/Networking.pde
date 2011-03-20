boolean writingObj = false;
String rEvent = "";
boolean debug = true;

void loadClientStream() {
  Client thisClient = server.available();
  // If the client is not null, and says something, display what it said
  if (thisClient !=null) {
    String in = thisClient.readString();
    
    if (in != null) {
     if (debug) println(":: " + in);
      for(int i = 0; i < in.length(); i++) {
      if (writingObj) {
        if (in.charAt(i) == '\r') {
          writingObj = false;
          
          loadTouchEvent(rEvent);    

          rEvent = "";
          
          println(in);
        }
        else if (in.charAt(i) == '\n') {
          println("ERRRRR, unexpect new event");
        }
        else {
          rEvent = rEvent+in.charAt(i);
        }
      }
      else {
        if (in.charAt(i)== '\n') {
          writingObj = true;
        }
      }
    }
      
        
    } 
    else {
      println("(empty)");
    } 
  }
}



void loadTouchEvent(String rawEvent) {
//  XMLElement xml = new XMLElement(this, "sites.xml");
  // x,y,px,py,t
  
  if (rawEvent.length() < 10 || !rawEvent.substring(0,1).equals("\t"))
  {
    println("whoops, "+rawEvent);
     println(split(rawEvent, "<TOUCH>"));
    return;
  }
  
  // Set the last event to this event.
  current_event = trim(rawEvent);
  active = true;
}
