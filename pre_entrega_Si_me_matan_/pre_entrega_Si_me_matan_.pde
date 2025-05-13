import processing.sound.*;

PImage hojas, cieloEstrellado, tierra, semillaImg, raicesImg;
PImage[] flores;

SoundFile cancion;
PFont fuente;

int escena = 0;
boolean mostrarLetra1 = false;
boolean mostrarLetra2 = false;

float circuloSize = 0;
boolean empezarCirculo = false;

// Escena 3
boolean mostrarSemilla = false;
boolean semillaClickeada = false;
ArrayList<PVector> floresPosiciones = new ArrayList<PVector>();

boolean botonPresionado = false;  // Para saber si el botón ha sido presionado

void setup() {
  size(800, 600);
  hojas = loadImage("hojas.png");
  cieloEstrellado = loadImage("cielo.png");
  tierra = loadImage("tierra.png");
  semillaImg = loadImage("semilla.png");
  raicesImg = loadImage("raices.png");

  cancion = new SoundFile(this, "silvana.mp3");

  fuente = createFont("Georgia", 24);
  textFont(fuente);
  textAlign(CENTER, CENTER);

  // Crear posiciones aleatorias para las flores
  for (int i = 0; i < 30; i++) {
    floresPosiciones.add(new PVector(random(width), random(height - 100, height)));
  }

  // Pantalla inicial con el botón de iniciar
  background(0);
  fill(255);
  textSize(32);
  text("Iniciar viaje", width / 2, height / 2);
}

void draw() {
  if (!botonPresionado) {
    // Pantalla inicial con el botón de "Iniciar viaje"
    if (mousePressed && mouseX > width / 4 && mouseX < 3 * width / 4 && mouseY > height / 2 - 50 && mouseY < height / 2 + 50) {
      botonPresionado = true;
      cancion.play(); // Inicia la canción
      escena = 1; // Empieza la primera escena
    }
  } else {
    // Si el botón fue presionado, manejar las escenas
    float tiempo = cancion.position(); // tiempo actual en segundos

    // --- ESCENA 1 ---
    if (escena == 1) {
      image(hojas, 0, 0, width, height);
      fill(255);
      textSize(24);
      text("si me matan", width/2, 100);

      if (mostrarLetra1) {
        fill(255);
        textSize(22);
        text("Cuando me encuentren\nQue digan siempre, que digan siempre", width/2, height/2);
      }

      if (mostrarLetra2) {
        fill(200, 200, 255);
        textSize(20);
        text("Que fui cantora\nViviendo sueños que como todas,\ncrecí con miedo", width/2, height/2 + 100);
      }

      if (tiempo >= 35.5) {
        escena = 2;
      }
    }

    // --- ESCENA 2 ---
    else if (escena == 2) {
      image(cieloEstrellado, 0, 0, width, height);

      fill(255);
      textSize(20);
      text("Salí solita a ver estrellas,\nA andar los días", width/2, 100);

      // Inicia el crecimiento del círculo
      empezarCirculo = true;

      if (empezarCirculo && circuloSize < 400) {
        circuloSize += 1.5;
      }

      // Dibuja el círculo amarillo
      fill(255, 255, 100, 200);
      ellipse(width/2, height/2 + 50, circuloSize, circuloSize);

      if (circuloSize >= 250) {
        fill(255);
        textSize(20);
        text("Salí solita a ver estrellas,\nA amar la vida", width/2, height/2 + 150);
      }

      // Transición a escena 3 después de que el círculo creció
      if (tiempo >= 50) {
        escena = 3;
      }
    }

    // --- ESCENA 3 ---
    else if (escena == 3) {
      image(tierra, 0, 0, width, height);

      fill(0, 200, 100);
      textSize(22);
      text("Si me matan, Si es que me encuentran", width/2, 100);

      // Aparecen flores progresivamente
      for (int i = 0; i < floresPosiciones.size(); i++) {
        PVector p = floresPosiciones.get(i);
        fill(random(100,255), random(100,255), random(100,255));
        ellipse(p.x, p.y, 10, 10);
      }

      fill(255);
      text("Llénenme de flores, cúbranme de tierra", width/2, 180);

      // Mostrar semilla si se hace clic
      if (mostrarSemilla && !semillaClickeada) {
        image(semillaImg, width/2 - 25, height/2 - 25, 50, 50);
      }

      if (semillaClickeada) {
        image(raicesImg, width/2 - 50, height/2, 100, 100);
        fill(255);
        textSize(20);
        text("Que yo seré semilla para las que vienen", width/2, height - 100);
      }

      // Final opcional con fondo estrellado y flores
      if (tiempo >= 70) {
        image(cieloEstrellado, 0, 0, width, height);
        fill(255);
        textSize(24);
        text("Que ya nadie nos calla\nYa nada nos contiene", width/2, height/2);
      }
    }
  }
}

void mousePressed() {
  if (escena == 1) {
    if (!mostrarLetra1) {
      mostrarLetra1 = true;
    } else if (!mostrarLetra2) {
      mostrarLetra2 = true;
    }
  } else if (escena == 3) {
    if (!mostrarSemilla) {
      mostrarSemilla = true;
    } else {
      // Si se hizo clic dentro de la imagen de la semilla
      if (mouseX > width/2 - 25 && mouseX < width/2 + 25 &&
          mouseY > height/2 - 25 && mouseY < height/2 + 25) {
        semillaClickeada = true;
      }
    }
  }
}
