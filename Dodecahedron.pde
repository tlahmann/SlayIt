import java.util.Collections;

class Dodecahedron {
  private ArrayList<PVector> vertices = new ArrayList<PVector>();
  private ArrayList<Float> verticeMagnitudes = new ArrayList<Float>();
  private float lineOffset = 0;
  private float maxRad = 200;
  private PVector rotation = new PVector(0, 0, 0);
  private int[][] faces;

  // publics
  public float rad = 0.0001f;
  public PVector rotationSpeed = new PVector(0.5, 0.5, 0.5);
  public PVector position = new PVector(0, 0, 0);
  public PVector speed = new PVector(0, 0, 0); 

  private ArrayList<CustomAnimation> anis = new ArrayList<CustomAnimation>();
  private ArrayList<Ani> activeAnis = new ArrayList<Ani>();

  Dodecahedron() {

    float golden = (1+sqrt(5))/2;

    vertices.add(new PVector(1, 1, 1)); //0
    vertices.add(new PVector(-1, 1, 1));
    vertices.add(new PVector(1, -1, 1));
    vertices.add(new PVector(-1, -1, 1));
    vertices.add(new PVector(1, 1, -1));
    vertices.add(new PVector(-1, 1, -1)); // 5
    vertices.add(new PVector(1, -1, -1));
    vertices.add(new PVector(-1, -1, -1));
    vertices.add(new PVector(0, golden, 1/golden));
    vertices.add(new PVector(0, -golden, 1/golden));
    vertices.add(new PVector(0, -golden, -1/golden)); // 10
    vertices.add(new PVector(0, golden, -1/golden)); 
    vertices.add(new PVector(1/golden, 0, golden));
    vertices.add(new PVector(-1/golden, 0, golden));
    vertices.add(new PVector(1/golden, 0, -golden));
    vertices.add(new PVector(-1/golden, 0, -golden)); // 15
    vertices.add(new PVector(golden, 1/golden, 0)); 
    vertices.add(new PVector(-golden, 1/golden, 0));
    vertices.add(new PVector(golden, -1/golden, 0));
    vertices.add(new PVector(-golden, -1/golden, 0));

    for (PVector v : vertices) { 
      verticeMagnitudes.add(1f);
    }

    faces = new int[12][5];

    faces[0] = new int[]{9, 10, 6, 18, 2};
    faces[1] = new int[]{9, 2, 12, 13, 3};
    faces[2] = new int[]{9, 10, 7, 19, 3};
    faces[3] = new int[]{12, 0, 16, 18, 2};
    faces[4] = new int[]{10, 6, 14, 15, 7};
    faces[5] = new int[]{18, 16, 4, 14, 6};
    faces[6] = new int[]{13, 12, 0, 8, 1};
    faces[7] = new int[]{3, 13, 1, 17, 19};
    faces[8] = new int[]{1, 8, 11, 5, 17};
    faces[9] = new int[]{19, 17, 5, 15, 7};
    faces[10] = new int[]{5, 11, 4, 14, 15};
    faces[11] = new int[]{8, 11, 4, 16, 0};
  }

  private void importAnimation() {
    AniImporter ai = new AniImporter();
    anis = new ArrayList<CustomAnimation>();
    anis.addAll(ai.importAnimation(this, "./timing/dode.json", "rad"));
    anis.addAll(ai.importAnimation(this, "./timing/dode.json", "lineOffset"));
    anis.addAll(ai.importAnimation(rotationSpeed, "./timing/dode_rot.json", "x"));
    anis.addAll(ai.importAnimation(rotationSpeed, "./timing/dode_rot.json", "y"));
    anis.addAll(ai.importAnimation(rotationSpeed, "./timing/dode_rot.json", "z"));
    anis.addAll(ai.importAnimation(this, "./timing/dode_rot.json", "smoothing"));
    Collections.sort(anis);
    activeAnis = new ArrayList<Ani>();
  }

  void update(float time) {
    for (PVector v : vertices) { 
      v.setMag(rad*maxRad);
    }

    rotation.x += rotationSpeed.x/100f; 
    rotation.y += rotationSpeed.y/100f; 
    rotation.z += rotationSpeed.z/100f; 
    
    position.x += speed.x;
    position.y += speed.y;
    position.z += speed.z;

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

  public float smoothing = 0.5f;

  void spike(int index, float mag) {
    if (index>=vertices.size()) return;
    float m = verticeMagnitudes.get(index);
    verticeMagnitudes.set(index, (m * smoothing) + ((maxRad + mag) * (1.0f - smoothing)));
    vertices.get(index).setMag(rad * m);
  }

  void setSmooth(int val) {
    smoothing = val/10f;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(rotation.x);
    rotateY(rotation.y);
    rotateY(rotation.z);
    strokeWeight(1);
    stroke(255);

    for (int i = 0; i < faces.length; i++) {
      float lines = random(1, 2);
      for (int j = 0; j < lines; j++) {
        line(vertices.get(faces[i][0]).x + random(lineOffset), vertices.get(faces[i][0]).y + random(lineOffset), vertices.get(faces[i][0]).z + random(lineOffset), 
          vertices.get(faces[i][1]).x + random(lineOffset), vertices.get(faces[i][1]).y + random(lineOffset), vertices.get(faces[i][1]).z + random(lineOffset));

        line(vertices.get(faces[i][1]).x + random(lineOffset), vertices.get(faces[i][1]).y + random(lineOffset), vertices.get(faces[i][1]).z + random(lineOffset), 
          vertices.get(faces[i][2]).x + random(lineOffset), vertices.get(faces[i][2]).y + random(lineOffset), vertices.get(faces[i][2]).z + random(lineOffset));

        line(vertices.get(faces[i][2]).x + random(lineOffset), vertices.get(faces[i][2]).y + random(lineOffset), vertices.get(faces[i][2]).z + random(lineOffset), 
          vertices.get(faces[i][3]).x + random(lineOffset), vertices.get(faces[i][3]).y +random(lineOffset), vertices.get(faces[i][3]).z + random(lineOffset));

        line(vertices.get(faces[i][3]).x + random(lineOffset), vertices.get(faces[i][3]).y + random(lineOffset), vertices.get(faces[i][3]).z + random(lineOffset), 
          vertices.get(faces[i][4]).x + random(lineOffset), vertices.get(faces[i][4]).y + random(lineOffset), vertices.get(faces[i][4]).z + random(lineOffset));

        line(vertices.get(faces[i][4]).x + random(lineOffset), vertices.get(faces[i][4]).y + random(lineOffset), vertices.get(faces[i][4]).z +random(lineOffset), 
          vertices.get(faces[i][0]).x +random(lineOffset), vertices.get(faces[i][0]).y + random(lineOffset), vertices.get(faces[i][0]).z + random(lineOffset));
      }

      line(vertices.get(faces[i][0]).x, vertices.get(faces[i][0]).y, vertices.get(faces[i][0]).z, 
        vertices.get(faces[i][1]).x, vertices.get(faces[i][1]).y, vertices.get(faces[i][1]).z);

      line(vertices.get(faces[i][1]).x, vertices.get(faces[i][1]).y, vertices.get(faces[i][1]).z, 
        vertices.get(faces[i][2]).x, vertices.get(faces[i][2]).y, vertices.get(faces[i][2]).z);

      line(vertices.get(faces[i][2]).x, vertices.get(faces[i][2]).y, vertices.get(faces[i][2]).z, 
        vertices.get(faces[i][3]).x, vertices.get(faces[i][3]).y, vertices.get(faces[i][3]).z);

      line(vertices.get(faces[i][3]).x, vertices.get(faces[i][3]).y, vertices.get(faces[i][3]).z, 
        vertices.get(faces[i][4]).x, vertices.get(faces[i][4]).y, vertices.get(faces[i][4]).z);

      line(vertices.get(faces[i][4]).x, vertices.get(faces[i][4]).y, vertices.get(faces[i][4]).z, 
        vertices.get(faces[i][0]).x, vertices.get(faces[i][0]).y, vertices.get(faces[i][0]).z);
    }

    popMatrix();
  }
}