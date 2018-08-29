import java.util.Collections;

class Laser {
  private ArrayList<CustomAnimation> anis = new ArrayList<CustomAnimation>();
  private ArrayList<Ani> activeAnis = new ArrayList<Ani>();

  ArrayList<PVector> lasers = new ArrayList<PVector>();
  int spawn = 0;

  Laser() {
    importAnimation();
  }

  private void importAnimation() {
    AniImporter ai = new AniImporter();
    anis = ai.importAnimation(this, "./timing/laser.json", "spawn");
    Collections.sort(anis);
    activeAnis = new ArrayList<Ani>();
  }

  void update(float time) {
    spawnLaser();

    if (anis.size() == 0) {
      return;
    }
    if (time / 1000 < anis.get(0).start) {
      return;
    }

    // Get a new animation
    CustomAnimation ani = anis.remove(0);
    activeAnis.add(Ani.to(ani.object, ani.duration, ani.param, ani.value, ani.easing));
    update(time);
  }

  void spawnLaser() {
    if (spawn <= 0) return;
    float a = random(TWO_PI);
    float z = random(200);
    float zz = (((int)(random(2))*2)-1)*z;
    lasers.add(new PVector(cos(a)*1000, sin(a)*1000, zz));
    spawn--;
  }

  void display() {
    pushMatrix();
    strokeWeight(2);
    stroke(255);
    translate(width/2, height/2);
    for (int i = lasers.size()-1; i >= 0; i--) {
      PVector s = lasers.get(i);
      PVector f = s.copy().mult(0.2);
      line(f.x, f.y, f.z, 
        s.x, s.y, s.z);
      s.mult(0.75);
      if (s.mag() < 1) {
        lasers.remove(i);
      }
    }
    popMatrix();
  }
}