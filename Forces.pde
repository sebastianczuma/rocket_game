class Forces {
  PVector gravity;
  PVector boost;
  PVector friction;

  float G = 6.6740831 * pow(10, -11);

  float calculateGravity(float m, float M, float distance) {
    return G * (m * M) / pow(distance, 2);
  }

  float checkDistanceToAstronomical(Astro astronomical, Player player) {
    return dist(astronomical.pos.x, astronomical.pos.y, player.pos.x, player.pos.y);
  }

  void calculateForces(ArrayList<Astro> astros, Player player) {
    gravity = new PVector();
    for (Astro astro : astros) {

      PVector planet = new PVector(player.pos.x - astro.pos.x, player.pos.y - astro.pos.y);
      float angle = atan2(planet.y, planet.x) + PI;

      float gravityValue = calculateGravity(player.rocket.m, astro.m, checkDistanceToAstronomical(astro, player) + 6371000);
      PVector gravityForce = PVector.fromAngle(angle);
      gravityForce.setMag(gravityValue);

      gravity.add(gravityForce);
    }
  }
}
