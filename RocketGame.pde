int framerate = 120;
float scaleFactor = 1.0;
float translateX;
float translateY;
boolean tracking = false;
boolean hints = true;
boolean rocketInfo = false;
PImage rocketImage;
PVector startPoint = new PVector(0, 0);
Player player;
ArrayList<Astro> astros = new ArrayList();
Rocket rocket;

void setup() {
  //size(1280, 690);
  fullScreen();
  frameRate(framerate);

  buildGameItems();
  player = new Player(astros, rocket, framerate);
  moveCameraToStart();
}

void buildGameItems() {
  Earth earth = new Earth(startPoint);
  Moon moon = new Moon(new PVector(3000, -4000));
  Falcon9 falcon9 = new Falcon9();

  earth.setParamteres();
  moon.setParamteres();
  falcon9.setParameters();

  rocket = falcon9;

  astros.add(earth);
  astros.add(moon);

  rocketImage = loadImage(rocket.imageUrl);
  rocketImage.resize(0, height - 300);
}

void moveCameraToStart() {
  translateX = width/2 - startPoint.x;
  translateY = height/2 - startPoint.y + astros.get(0).r;
}

void draw() {
  background(0);
  pushMatrix();
  translate(translateX, translateY);
  scale(scaleFactor);

  for (Astro astronomical : astros) {
    astronomical.drawAstronomical();
  }
  player.update();
  player.show();

  popMatrix();


  drawText();
  showRocketHud();
  if (tracking) {
    tracking();
  }
}

void tracking() {
  translateX = width/2 - (scaleFactor * player.pos.x);
  translateY = height/2 - (scaleFactor * player.pos.y);
}

void showRocketHud() {
  noStroke();
  fill(0, 180);
  rect(width-120, height-120, 120, 120);
  pushMatrix();
  translate(width-60, height - 60);
  //scale(2);
  rotate(player.rotation);

  if (player.boosting ) {
    player.boostCount --;
    if (floor(((float)player.boostCount)/3)%2 == 0) {
      stroke(247, 161, 0);
      strokeWeight(4);

      line(0, -4 - rocket.massCenter, -2, -15 - rocket.massCenter);
      line(0, -4 - rocket.massCenter, 2, -15 - rocket.massCenter);

      stroke(255, 255, 255);
      strokeWeight(1);
    }
  }

  rocket.drawRocket();

  popMatrix();

  drawAccVelVectors();
}

void drawAccVelVectors() {
  pushMatrix();
  translate(width-150, height-93);
  rotate(player.velAngle()+PI/2);
  if (player.vel.mag() == 0) {
  } else {
    line(0, 0, 0, -20);
    line(0, -20, -5, -15);
    line(0, -20, 5, -15);
  }
  popMatrix();

  pushMatrix();
  translate(width-150, height-33);
  rotate(player.accAngle()+PI/2);
  if (player.acc.mag() == 0) {
  } else {
    line(0, 0, 0, -20);
    line(0, -20, -5, -15);
    line(0, -20, 5, -15);
  }
  popMatrix();
}


void drawText() {
  noStroke();
  fill(0, 180);
  rect(0, 0, 275, 50);

  fill(255);
  textAlign(LEFT);
  textSize(22);
  text("ROCKET AI", 20, 30);

  noStroke();
  fill(0, 180);
  rect(width-280, 0, 280, 30);

  fill(255);
  textAlign(RIGHT);
  textSize(14);
  text("Elapsed time: " + millis()/1000, width - 10, 20);

  textAlign(LEFT);
  if (hints) {
    noStroke();
    fill(0, 180);
    rect(0, 50, 275, 200);

    fill(255);
    text("Press 'h' to hide hints", 20, 80);
    text("Press 'i' to show info about rocket", 20, 100);
    text("Press 't' to enable rocket tracking", 20, 120);
    text("Press 'z' to zoom at rocket", 20, 140);
    text("Press 's' to stop rocket", 20, 160);
    text("Press 'r' to reset", 20, 180);
  } else {
    noStroke();
    fill(0, 180);
    rect(0, 50, 275, 45);

    fill(255);
    text("Press 'h' to show hints", 20, 80);
  }

  if (rocketInfo) {
    noStroke();
    fill(0, 180);
    rect(width-280, 30, 280, height-150);

    image(rocketImage, width - 82, 100);

    fill(255);
    textAlign(CENTER);
    textSize(16);
    text(rocket.name, width-140, 70);
    textAlign(LEFT);
    textSize(14);
    text("Made by: " + rocket.manufacturer, width-260, 140);
    text("Version: " + rocket.version, width-260, 170);
    text("Drive: " + rocket.drive, width-260, 200);
    text("Mass: " + rocket.m + " [kg]", width-260, 230);
    text("Height: " + rocket.rocketHeight + " [m]", width-260, 260);
    text("Width: " + rocket.rocketWidth + " [m]", width-260, 290);
    text("Thrust: " + rocket.thrust/1000 + " [kN]", width-260, 320);
  }

  noStroke();
  fill(0, 180);
  rect(0, height-70, width-280, 70);
  rect(width-280, height-120, 160, 120);

  fill(255);
  textSize(14);

  float  playerVel = player.vel.mag();
  String playerVelUnit;
  if (abs(playerVel) > 1000) {
    playerVel = playerVel / 1000;
    playerVelUnit = "km";
  } else {
    playerVelUnit = "m";
  }
  text("Velocity [" + playerVelUnit + "/s]: " + String.format("%.5f", playerVel), 20, height-40);

  float  playerAcc = player.acc.mag();
  String playerAccUnit;
  if (abs(playerAcc) > 1000) {
    playerAcc = playerAcc / 1000;
    playerAccUnit = "km";
  } else {
    playerAccUnit = "m";
  }
  text("Acceleration [" + playerAccUnit + "/s\u00B2]: " + String.format("%.5f", playerAcc), 20, height-20);

  float  playerPosX = player.pos.x;
  String posXUnit;
  if (abs(playerPosX) > 1000*1000) {
    playerPosX = playerPosX / 1000;
    posXUnit = "km";
  } else {
    posXUnit = "m";
  }
  text("X position [" + posXUnit + "]: " + String.format("%.2f", playerPosX), 280, height-40);

  float  playerPosY = -player.pos.y;
  String posYUnit;
  if (abs(playerPosY) > 1000*1000) {
    playerPosY = playerPosY / 1000;
    posYUnit = "km";
  } else {
    posYUnit = "m";
  }
  text("Y position [" + posYUnit + "]: " + String.format("%.2f", playerPosY), 280, height-20);

  String trackingString;
  if (tracking) {
    trackingString = "Enabled";
  } else {
    trackingString = "Disabled";
  }
  text("Tracking: " + trackingString, 560, height-40);

  float distanceToEarth = player.checkDistanceToEarth();
  String distanceUnit;
  if (distanceToEarth > 1000*1000) {
    distanceToEarth = distanceToEarth / 1000;
    distanceUnit = "km";
  } else {
    distanceUnit = "m";
  }
  text("Distance to Earth [" + distanceUnit + "]: " + String.format("%.2f", distanceToEarth), 560, height-20);


  line(width-280, height-60, width-120, height-60);
  textAlign(CENTER);

  text("Velocity\n" + String.format("%.2f", degrees(-player.velAngle())) + "\u00b0", 1050, height-96);
  text("Acceleration\n" + String.format("%.2f", degrees(-player.accAngle())) + "\u00b0", 1050, height-36);
}

void keyPressed() {
  if (key == 'h') {
    if (hints) {
      hints = false;
    } else {
      hints = true;
    }
  }

  if (key == 'r') {
    scaleFactor = 1;
    player.resetPositions();
    moveCameraToStart();
  }

  if (key == 's') {
    player.stopPlayer();
  }

  if (key == 'z') {
    scaleFactor = 1;
    translateX = width/2 - player.pos.x;
    translateY = height/2 - player.pos.y;
  }

  if (key == 't') {
    if (tracking) {
      tracking = false;
    } else {
      tracking = true;
    }
  }

  if (key == 'i') {
    if (rocketInfo) {
      rocketInfo = false;
    } else {
      rocketInfo = true;
    }
  }

  if (key == CODED) {
    if (keyCode == UP) {
      player.boosting = true;
    }
    if (keyCode == LEFT) {
      player.spin = -0.08;
    } else if (keyCode == RIGHT) {
      player.spin = 0.08;
    }
  }
}

void mouseDragged(MouseEvent e) {
  translateX += mouseX - pmouseX;
  translateY += mouseY - pmouseY;
}

void mouseWheel(MouseEvent e) {
  translateX -= mouseX;
  translateY -= mouseY;
  float delta = e.getCount() > 0 ? 1.05 : e.getCount() < 0 ? 1.0/1.05 : 1.0;
  scaleFactor *= delta;
  translateX *= delta;
  translateY *= delta;
  translateX += mouseX;
  translateY += mouseY;
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      player.boosting = false;
    }
    if (keyCode == LEFT) {
      player.spin = 0;
    } else if (keyCode == RIGHT) {
      player.spin = 0;
    }
  }
}
