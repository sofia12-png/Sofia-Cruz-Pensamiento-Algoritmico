int catX = 50, catY = 300, catVelocity = 0;
boolean onGround = true, gameWon = false;
int gravity = 1, jumpStrength = -10;

Cloud[] clouds = {
  new Cloud(150, 250),
  new Cloud(300, 200),
  new Cloud(450, 150),
  new Cloud(600, 100)
};

int fishX = 650, fishY = 50;
int stars = 100;
float[] starX = new float[stars];
float[] starY = new float[stars];

void setup() {
  size(800, 400);
  for (int i = 0; i < stars; i++) {
    starX[i] = random(width);
    starY[i] = random(height / 2);
  }
}

void draw() {
  background(10, 10, 30); // Cielo nocturno
  drawStars();

  // Nubes (reemplazo de cubos)
  for (Cloud c : clouds) {
    c.display();
  }

  // Suelo
  fill(50);
  rect(0, 350, width, 50);

  // Pez dorado
  fill(255, 215, 0);
  ellipse(fishX, fishY, 30, 20);

  // Gato
  fill(255);
  ellipse(catX, catY, 30, 30);

  if (!gameWon) {
    catY += catVelocity;
    catVelocity += gravity;
    onGround = catY >= 320;

    if (onGround) {
      catY = 320;
      catVelocity = 0;
    }

    for (Cloud c : clouds) {
      if (catX >= c.x && catX <= c.x + c.w && catY + 15 >= c.y && catY + 15 <= c.y + 10) {
        catY = c.y - 15;
        catVelocity = 0;
        onGround = true;
      }
    }

    if (dist(catX, catY, fishX, fishY) < 20) {
      gameWon = true;
    }
  } else {
    for (int i = 0; i < 100; i++) {
      fill((int)random(255), (int)random(255), (int)random(255));
      ellipse((int)random(width), (int)random(height), 10, 10);
    }
  }
}

// Evento: salto con clic
void mousePressed() {
  if (onGround && !gameWon) {
    catVelocity = jumpStrength;
    onGround = false;
  }
}

// Evento: mover gato con teclas
void keyPressed() {
  if (!gameWon) {
    if (keyCode == RIGHT) {
      catX += 10;
    } else if (keyCode == LEFT) {
      catX -= 10;
    }
  }
}

// Evento: mover pez con el mouse
void mouseMoved() {
  if (!gameWon) {
    fishX = mouseX;
    fishY = mouseY;
  }
}

// Dibuja estrellas
void drawStars() {
  fill(255);
  for (int i = 0; i < stars; i++) {
    ellipse(starX[i], starY[i], 2, 2);
  }
}

// Clase: nube
class Cloud {
  int x, y, w = 50, h = 30;

  Cloud(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    fill(173, 216, 230); // azul claro
    ellipse(x + 10, y + 10, w, h);
    ellipse(x + 25, y, w, h);
    ellipse(x + 40, y + 10, w, h);
  }
}
