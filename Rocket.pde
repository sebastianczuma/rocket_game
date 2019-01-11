abstract class Rocket {
  String imageUrl;
  String name;
  String manufacturer;
  String version;
  String drive;
  float massCenter;
  float m;
  float rocketHeight;
  float rocketWidth;
  int thrust;

  void setParameters(String imageUrl, String name, String manufacturer, String version, String drive, float massCenter, float mass, float rocketHeight, float rocketWidth, int thrust) {
    this.imageUrl = imageUrl;
    this.name = name;
    this.manufacturer = manufacturer;
    this. version = version;
    this.drive = drive;
    this.massCenter = massCenter;
    this.m = mass;
    this.rocketHeight = rocketHeight;
    this.rocketWidth = rocketWidth;
    this.thrust = thrust;
  }

  abstract void drawRocket();
}
