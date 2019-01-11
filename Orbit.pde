class Orbit {
  Astro earth;
  float G = 6.6740831 * pow(10, -11);

  Orbit(Astro earth) {
    this.earth = earth;
  }

  float calculateRadius(float speed) {
    return (G * earth.m) / pow(speed, 2);
  }

  void show(float speed) {
    float radius = calculateRadius(speed) / 6371;
    noFill();
    stroke(255);

    int npoints = 24;
    float angle = TWO_PI / npoints;//set the angle between vertexes
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {//draw each vertex of the polygon
      float sx = earth.pos.x + cos(a) * radius;//math
      float sy = earth.pos.y + sin(a) * radius;//math
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
