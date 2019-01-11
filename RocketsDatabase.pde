class Falcon9 extends Rocket {
  String imageUrl = "falcon9.png";
  String name = "Falcon 9";
  String manufacturer = "SpaceX";
  String version = "FT";
  String drive = "9 x Merlin 1D";
  float massCenter = 30;
  float m = 541300;
  float rocketHeight = 70;
  float rocketWidth = 3.66;
  int thrust = 6806000;

  void setParameters() {
    super.setParameters(imageUrl, name, manufacturer, version, drive, massCenter, m, rocketHeight, rocketWidth, thrust);
  }

  @Override
    void drawRocket() {
    noFill();
    stroke(255);

    beginShape();
    vertex(-rocketWidth/2, -massCenter);
    vertex(-(rocketWidth/2)+1, 4 - massCenter);
    vertex(-rocketWidth/2, 6 - massCenter);
    vertex(-rocketWidth/2, rocketHeight-4 - massCenter);
    vertex(0, rocketHeight - massCenter);
    vertex(rocketWidth/2, rocketHeight-4 - massCenter);
    vertex(rocketWidth/2, 6 - massCenter);
    vertex(rocketWidth/2-1, 4 - massCenter);
    vertex(rocketWidth/2, -massCenter);
    endShape(CLOSE);
  }
}
