class Earth extends Astro {
  PVector pos;
  float m = (5.97219 * pow(10, 24));
  float r = 1000;

  Earth(PVector position) {
    super(position);
    this.pos = position;
  }

  void setParamteres() {
    super.setParamteres(r, m);
  }

  @Override void drawAstronomical() {
    noFill();
    stroke(255);

    int npoints = 128;
    float angle = TWO_PI / npoints;//set the angle between vertexes
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {//draw each vertex of the polygon
      float sx = pos.x + cos(a) * r;//math
      float sy = pos.y + sin(a) * r;//math
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

class Moon extends Astro {
  PVector pos;
  float m = (7.347673 * pow(10, 22));
  float r = 300;

  Moon(PVector position) {
    super(position);
    this.pos = position;
  }

  void setParamteres() {
    super.setParamteres(r, m);
  }

  @Override void drawAstronomical() {
    noFill();
    stroke(255);

    int npoints = 128;
    float angle = TWO_PI / npoints;//set the angle between vertexes
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {//draw each vertex of the polygon
      float sx = pos.x + cos(a) * r;//math
      float sy = pos.y + sin(a) * r;//math
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
