int numShapes = 10; // Número de figuras
Shape[] shapes;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100);  // Usamos HSB para controlar mejor los colores
  shapes = new Shape[numShapes];
  
  for (int i = 0; i < numShapes; i++) {
    shapes[i] = new Shape(random(width), random(height), random(20, 80));
  }
}

void draw() {
  background(#1A03FC); // Fondo azul fijo
  for (int i = 0; i < numShapes; i++) {
    shapes[i].update();
    shapes[i].display();
  }
}

class Shape {
  float x, y;
  float size;
  float speedX, speedY;
  float hueValue;
  
  Shape(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.speedX = random(-2, 2);
    this.speedY = random(-2, 2);
    this.hueValue = random(360);
  }
  
  void update() {
    // Movimiento orgánico
    x += speedX * noise(frameCount * 0.01);
    y += speedY * noise(frameCount * 0.01);
    
    // Cambio de color dinámico
    hueValue = (hueValue + 1) % 360;
    
    // Cambio de tamaño pulsante
    size = map(sin(frameCount * 0.05), -1, 1, 20, 80);
    
    // Rebote en los bordes
    if (x < 0 || x > width) speedX *= -1;
    if (y < 0 || y > height) speedY *= -1;
  }
  
  void display() {
    fill(hueValue, 80, 100, 80);
    noStroke();
    ellipse(x, y, size, size);
  }
}
