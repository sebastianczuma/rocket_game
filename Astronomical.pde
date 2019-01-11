abstract class Astro {
  PVector pos;
  float r;
  float m;

  Astro(PVector position) {
    this.pos = position;
  }

  void setParamteres(float radius, float mass) {
    this.r = radius;
    this.m = mass;
  }

  abstract void drawAstronomical();
}
