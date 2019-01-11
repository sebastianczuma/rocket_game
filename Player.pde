class Player {
  float dT;
  PVector acc = new PVector();  
  PVector vel = new PVector();
  PVector pos = new PVector();

  float rotation;
  float spin;
  float maxSpeed = 8;
  boolean boosting = false;
  int boostCount = 10;

  ArrayList<Astro> astros;
  Forces forces;
  Rocket rocket;
  PImage rocketImage;

  Player(ArrayList<Astro> astros, Rocket rocket, int framerate) {
    this.dT = (float) 1/framerate;
    this.astros = astros;
    this.forces = new Forces();
    this.rocket = rocket;
    resetPositions();
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y - rocket.massCenter);
    showRocketInfo();
    rotate(rotation);

    if (boosting ) {
      boostCount --;
      if (floor(((float)boostCount)/3)%2 == 0) {
        stroke(247, 161, 0);
        strokeWeight(4);

        line(0, -4 - rocket.massCenter, -5, -40 - rocket.massCenter);
        line(0, -4 - rocket.massCenter, 5, -40 - rocket.massCenter);

        stroke(255, 255, 255);
        strokeWeight(1);
      }
    }

    rocket.drawRocket();

    popMatrix();
  }

  void update() {
    move();
    checkPositions();
  }

  void move() {
    acc = new PVector();
    rotatePlayer();
    if (boosting) {
      boost();
    } else {
      boostOff();
    }

    if (!checkIfRocketOnGround()) {
      gravityAcceleration();
    }

    calculateVelocity();
    calculatePosition();
  }

  void checkPositions() {
    if (checkIfRocketHit()) {
      playerHit();
    }
    if (checkIfRocketOnGround()) {
      rocketOnGround();
    }
  }

  void boostAcceleration() {
    PVector boostAcc = PVector.fromAngle(rotation+PI/2); 
    float a = rocket.thrust / rocket.m;
    boostAcc.setMag(a);

    acc.add(boostAcc);
  }

  void gravityAcceleration() {
    forces.calculateForces(astros, this);
    PVector gravityA = forces.gravity;
    float gravity = gravityA.mag();
    float a = gravity / rocket.m;
    gravityA.setMag(a);
    acc.add(gravityA);
  }

  void calculateVelocity() {
    PVector deltaV = new PVector(acc.x * dT, acc.y * dT);
    vel.x = vel.x + deltaV.x;
    vel.y = vel.y + deltaV.y;
  }

  void calculatePosition() {
    pos.x = pos.x + (vel.x * dT) + ((acc.x * pow(dT, 2))/2);
    pos.y = pos.y + (vel.y * dT) + ((acc.y * pow(dT, 2))/2);
  }

  void boost() {
    boostAcceleration();
  }

  void boostOff() {
    acc.setMag(0);
  }

  void rotatePlayer() {
    rotation += spin;
  }

  void playerHit() {
    //resetPositions();
  }

  void rocketOnGround() {
    vel.x = 0.0;
    vel.y = 0.0;

    acc = new PVector();  
    acc.setMag(0);
  }

  boolean checkIfRocketHit() {
    for (Astro astronomical : astros) {
      if (dist(astronomical.pos.x, astronomical.pos.y, pos.x, pos.y) < astronomical.r-10) {
        return true;
      }
    }

    return false;
  }

  boolean checkIfRocketOnGround() {
    for (Astro astronomical : astros) {
      if (dist(astronomical.pos.x, astronomical.pos.y, pos.x, pos.y) < astronomical.r) {
        return true;
      }
    }

    return false;
  }

  float checkDistanceToEarth() {
    return dist(astros.get(0).pos.x, astros.get(0).pos.y, pos.x, pos.y) - astros.get(0).r;
  }

  float accAngle() {
    return atan2(acc.y, acc.x);
  }

  float velAngle() {
    return atan2(vel.y, vel.x);
  }


  void showRocketInfo() {
    fill(255);
    textAlign(LEFT);
    textSize(12);
    text("Acceleration: " + String.format("%.5f", acc.mag()), 30, -20);
    text("Velocity: " + String.format("%.5f", vel.mag()), 30, -40);
    text("Distance from Earth: " + String.format("%.2f", checkDistanceToEarth()), 30, -60);
  }

  void resetPositions() {
    float earthSide = astros.get(0).pos.x;
    float earthTop = astros.get(0).pos.y - astros.get(0).r;
    pos.x = earthSide;
    pos.y = earthTop;
    vel.x = 0.0;
    vel.y = 0.0;
    rotation = PI;

    acc.setMag(0);
  }

  void stopPlayer() {
    vel.x = 0.0;
    vel.y = 0.0;
    acc.setMag(0);
  }
}
