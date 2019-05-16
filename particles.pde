ParticleSystem ps;

void setup() {
  size(640, 360);
  ps = new ParticleSystem(new PVector(width/2, height - 50));
}

void draw() {
  background(0);
  ps.addParticle();
  ps.run();
}


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
