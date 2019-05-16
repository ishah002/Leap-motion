import de.voidplus.leapmotion.*;

LeapMotion leap;    //instance variable


//initialisation
ParticleSystem ps;
void setup()
{
  size(1024, 768, P3D); //dimensions and renderer
  background(255);
  leap = new LeapMotion(this);
  ps = new ParticleSystem();
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
  

     ps.addParticle(sphere_position,abs(handroll),new PVector(0,0.05));
     ps.run();
    
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


// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 


class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float ParticleSize;

  Particle(PVector l) {
     acceleration = new PVector(0, 0.001); //speed
    velocity = new PVector(random(-0.3, 0.2), random(0.2, 0.4));  //space
    position = l.copy();
    lifespan = 255.0;
    ParticleSize = random (12, 22);
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.sub(velocity);
    lifespan -= 0.7;
  }

  // Method to display
  void display() {
    noStroke();
    //stroke(255, 165, 10, lifespan);
    fill(226, constrain(lifespan + 20, 0, 255), 34, lifespan);
    //fill(226, 88, 34, lifespan);
    ellipse(position.x, position.y, ParticleSize, ParticleSize);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}


class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  void addParticle(PVector l,float height, PVector speed) {
    particles.add(new Particle(l, height,speed));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float ParticleSize;

  Particle(PVector l,float height, PVector speed) {
     acceleration = speed; //speed
    velocity = new PVector(random(-0.75, 0.75), random(0.2, 0.4));  //space
    position = l.copy();
    lifespan = height;
    ParticleSize = random (12, 22);
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.sub(velocity);
    lifespan -= 0.7;
  }

  // Method to display
  void display() {
    noStroke();
    //stroke(255, 165, 10, lifespan);
    fill(226, constrain(lifespan + 20, 0, 255), 34, lifespan);
    //fill(226, 88, 34, lifespan);
    ellipse(position.x, position.y, ParticleSize, ParticleSize);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
