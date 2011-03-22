class ServoJoint {
  String title;
  int pin;
  
  float current_pos  = 0;
  float target_pos   = 0;
  
  ServoJoint(String iTitle, int iPin) {
    title   = iTitle;
    pin     = iPin;
  }
}

class ServoControl {
  HashMap servos = new HashMap();
  
  
  void addServo(ServoJoint newServo) {
    servos.put(newServo.title, newServo);
  }
  
  void moveServo(String servo, int value) {
    return; 
  }
}
