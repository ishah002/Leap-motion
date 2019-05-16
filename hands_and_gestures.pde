import de.voidplus.leapmotion.*;

LeapMotion leap;    //instance variable

//initialisation
void setup()
{
  size(1024, 768, P3D); //dimensions and renderer
  background(255);
  leap = new LeapMotion(this);
}


void draw()
{
  background(255);
  
  leap.getHands();
  
  //____________HANDS____________
  
  for (Hand hand : leap.getHands()) {
    
    //initializing hand attributes for each hand seen by the leap motion 
    int     hand_id    =      hand.getId();
    PVector hand_position =   hand.getPosition();
    PVector hand_stabilized = hand.getStabilizedPosition();
    PVector hand_direction =  hand.getDirection();
    PVector hand_dynamics =   hand.getDynamics();
    float   handroll =        hand.getRoll();    //z axis
    float   hand_pitch =      hand.getPitch();  //x axis
    float   hand_yaw =        hand.getYaw();  //y axis
    boolean hand_is_left = hand.isLeft();
    boolean hand_is_right = hand.isRight();
    float   hand_grab = hand.getGrabStrength();
    float   hand_pinch = hand.getPinchStrength();
    float   hand_time = hand.getTimeVisible();
    PVector sphere_position = hand.getSpherePosition();
    float   sphere_radius = hand.getSphereRadius();
    
//--------Specific finger-------    
    Finger finger_thumb = hand.getThumb();
    Finger finger_index = hand.getIndexFinger();
    Finger finger_ring = hand.getRingFinger();
    Finger finger_pink = hand.getPinkyFinger();
    
//-------DRAW HANDS---------------------
  hand.draw();
  
  
    ellipse(sphere_position.x,sphere_position.y,abs(handroll),abs(handroll));
    
    //Finger FOR loop and get attributes
    for (Finger finger : hand.getFingers())
    {
      
      // ______BASICS_____
      int finger_id = finger.getId();
      PVector finger_position = finger.getPosition();
      PVector finger_stabilized = finger.getStabilizedPosition();
      PVector finger_velocity = finger.getVelocity();
      PVector finger_direction = finger.getDirection();
      float finger_time = finger.getTimeVisible();
      
      
      
      //______finger type_____
      switch(finger.getType()){
        
        case 0: //Thumb
         // background(0, 255, 0);
          break;
        case 1: //Index
          //strokeWeight(5);
          //stroke(0);
          //fill(#ff0000);
          //ellipse(finger.getPosition().x,finger.getPosition().y, 50, 50);
          break;
        case 2: //Middle
          break;
        case 3:  //Ring
          break;
        case 4:  //Pinky
          break;
      
    }  //switch
    
    //--------TOUCH EMULATION------
    int touch_zone  = finger.getTouchZone();
    float touch_distance  =finger.getTouchDistance();
    
    //switch(touch_zone)
    //{
    //  case -1: //None
    //    break;
    //  case 0: //Hovering
    //    background(255, 255, 0); //yellow
    //    println("hovering (#" + finger_id + "):"  + touch_distance);
    //    break;
    //  case 1: //touching
    //    background(0, 0, 255); //blue       
    //    println("Touching (#" + finger_id + "):" + touch_distance);
    //    break;
    //}
      
    }  //finger loop
   

    
    
  }// hands loop
    
}
/*

If(hand_Pinch() == 1.00){
  
  when pinch is pniching update per frame the position of the 
  ellipse(finger.getPosition().x,finger.getPosition().y, 50, 50);
}

*/
