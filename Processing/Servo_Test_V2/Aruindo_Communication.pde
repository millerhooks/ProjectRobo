void sendMessage(float s, float e, float w, float c) {
  if (arduino_comm_mode == 0) {
    
  }
  current_event = "<s"+int(s)+"><e"+int(e)+"><w"+int(w)+"><c"+int(c)+">";
  
  //port.write(current_event);
  println(current_event);
}

void eventLoop() {
  
}
