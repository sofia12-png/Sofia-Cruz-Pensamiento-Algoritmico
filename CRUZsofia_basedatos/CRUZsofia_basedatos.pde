Table table;
ArrayList<SongParticle> particles = new ArrayList<SongParticle>();
int releaseIndex = 0;
int releaseRate = 3; // cuantos datos se liberan por frame
PFont font;
boolean exploded = false;
color bg1 = color(5, 15, 20);
color bg2 = color(10, 30, 10);
boolean toggleColor = false;
ArrayList<Wave> waves = new ArrayList<Wave>();
PImage headphonesImg; // variable para almacenar la imagen de los audífonos

void setup() {
  size(1200, 800);
  background(bg1);
  table = loadTable("songs_clean.csv", "header");
  font = createFont("Arial", 12);
  textFont(font);
  ellipseMode(CENTER);
  headphonesImg = loadImage("headphones.png"); // cargar la imagen de los audífonos
}

void draw() {
  if (!exploded) {
    background(bg1);
    // Dibujar la imagen de los audífonos
    imageMode(CENTER);
    image(headphonesImg, width/2, height/2, 300, 200); // Ajusta el tamaño según necesites

  } else {
    background(toggleColor ? bg1 : bg2);
    toggleColor = frameCount % 30 < 15; // titila

    int added = 0;
    while (releaseIndex < table.getRowCount() && added < releaseRate) {
      TableRow row = table.getRow(releaseIndex);
      particles.add(new SongParticle(row.getString("name"), row.getFloat("energy"), row.getFloat("valence")));
      releaseIndex++;
      added++;
    }

    // Dibujar ondas concéntricas
    for (int i = waves.size() - 1; i >= 0; i--) {
      Wave w = waves.get(i);
      w.update();
      w.display();
      if (w.finished()) {
        waves.remove(i);
      }
    }

    for (SongParticle p : particles) {
      p.update();
      p.display();
    }

    // Agregar nuevas ondas cada cierto tiempo
    if (frameCount % 20 == 0) {
      waves.add(new Wave());
    }
  }
}

void mousePressed() {
  if (!exploded) exploded = true;
}

class SongParticle {
  String name;
  float energy, valence;
  float angle, radius;
  float x, y;
  float speed;
  float alpha = 0;
  float size;
  color col;

  SongParticle(String name, float energy, float valence) {
    this.name = name;
    this.energy = energy;
    this.valence = valence;
    this.angle = random(TWO_PI);
    this.radius = 0;
    this.speed = map(energy, 0, 1, 2, 10);
    this.size = map(valence, 0, 1, 10, 25);
    this.col = lerpColor(color(0, 255, 200), color(0, 200, 100), valence);
  }

  void update() {
    radius += speed;
    alpha = min(alpha + 5, 255);
    x = width/2 + cos(angle) * radius;
    y = height/2 + sin(angle) * radius;
  }

  void display() {
    fill(col, alpha);
    noStroke();
    ellipse(x, y, size, size);

    fill(255, alpha);
    textAlign(CENTER);
    text(name, x, y - size);
  }
}

class Wave {
  float radius = 0;
  float maxRadius = 600;
  float speed = 4;
  float alpha = 255;

  void update() {
    radius += speed;
    alpha -= 2.5;
  }

  void display() {
    noFill();
    stroke(0, 255, 200, alpha);
    strokeWeight(2);
    ellipse(width/2, height/2, radius*2, radius*2);
  }

  boolean finished() {
    return alpha <= 0;
  }
}
