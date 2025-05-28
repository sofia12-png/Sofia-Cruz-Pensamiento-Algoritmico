import processing.sound.*;

PImage hojas, hojas2, cieloEstrellado, tierra, semillaImg, raicesImg;
PImage[] floresImgs = new PImage[7];
SoundFile cancion;
PFont fuente;

int escena = 0;
boolean mostrarSemilla = false;
boolean semillaClickeada = false;
boolean botonPresionado = false;

ArrayList<Flor> flores = new ArrayList<Flor>();
Boton botonInicio;

String letraCancion = "";
ArrayList<FragmentoLetra> fragmentos = new ArrayList<FragmentoLetra>();

float circuloSizeRojo = 0;
float circuloSizeAzul = 0;

// Estrellas
PVector[] estrellas = new PVector[100];

// Variables para fade flores
int indiceFlor = 0;
float opacidadFlor = 0;
float duracionFade = 1.0;
float tiempoUltimaFlor = 0;
float intervaloFlor = 1.5;
boolean mostrandoFlor = false;

// Para controlar el tiempo de la escena final
float tiempoInicioEscena0 = -1;

// --------- CLASE FLOR ------------
class Flor {
  PVector pos;
  color col;

  Flor(float x, float y) {
    pos = new PVector(x, y);
    col = color(random(100, 255), random(100, 255), random(100, 255));
  }

  void dibujar() {
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, 10, 10);
  }
}

// --------- CLASE BOTÓN ------------
class Boton {
  float x, y, w, h;
  String texto;

  Boton(float x, float y, float w, float h, String texto) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.texto = texto;
  }

  void dibujar() {
    fill(255);
    rect(x, y, w, h, 10);
    fill(0);
    textSize(24);
    textAlign(CENTER, CENTER);
    text(texto, x + w/2, y + h/2);
  }

  boolean fuePresionado(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}

// --------- CLASE FRAGMENTO LETRA ------------
class FragmentoLetra {
  String texto;
  float tiempoInicio;
  float tiempoFin;

  FragmentoLetra(String texto, float inicio, float fin) {
    this.texto = texto;
    this.tiempoInicio = inicio;
    this.tiempoFin = fin;
  }

  String getTextoParcial(float tActual) {
    float duracion = tiempoFin - tiempoInicio;
    float progreso = constrain((tActual - tiempoInicio) / duracion, 0, 1);
    int numCaracteres = int(progreso * texto.length());
    return texto.substring(0, numCaracteres);
  }

  boolean estaActivo(float tActual) {
    return tActual >= tiempoInicio && tActual <= tiempoFin;
  }
}

// --------- SETUP ------------
void setup() {
  size(800, 600);
  hojas = loadImage("hojas.png");
  hojas2 = loadImage("hojas2.png");
  cieloEstrellado = loadImage("cielo.png");
  tierra = loadImage("tierra.png");
  semillaImg = loadImage("semilla.png");
  raicesImg = loadImage("raices.png");

  floresImgs[0] = loadImage("flores1.png");
  floresImgs[1] = loadImage("flores2.png");
  floresImgs[2] = loadImage("flores3.png");
  floresImgs[3] = loadImage("flores4.png");
  floresImgs[4] = loadImage("flores5.png");
  floresImgs[5] = loadImage("flores6.png");
  floresImgs[6] = loadImage("flores.png");

  cancion = new SoundFile(this, "silvana.mp3");

  fuente = createFont("Georgia", 42);
  textFont(fuente);
  textAlign(CENTER, CENTER);

  for (int i = 0; i < 30; i++) {
    flores.add(new Flor(random(width), random(height - 100, height)));
  }

  for (int i = 0; i < estrellas.length; i++) {
    estrellas[i] = new PVector(random(width), random(height));
  }

  botonInicio = new Boton(width/4, height/2 - 50, width/2, 100, "Iniciar viaje");

  fragmentos.add(new FragmentoLetra("Si me matan", 5, 7.8));
  fragmentos.add(new FragmentoLetra("que digan siempre", 9, 24.1));
  fragmentos.add(new FragmentoLetra("que fui cantora... Crecí con miedo", 24.3, 42.1));
  fragmentos.add(new FragmentoLetra("y aun así", 44.6, 49.1));
  fragmentos.add(new FragmentoLetra("salí solita a ver estrellas, a andar los días", 49.1, 63.2));
  fragmentos.add(new FragmentoLetra("salí solita a ver estrellas, a amar la vida", 65.1, 83.4));
  fragmentos.add(new FragmentoLetra("si me matan, si es que me encuentran", 85.1, 93.0));
  fragmentos.add(new FragmentoLetra("llénenme de flores, cúbranme de tierra", 94.6, 103.1));
  fragmentos.add(new FragmentoLetra("que yo seré semilla para las que vienen", 104.1, 112.8));
  fragmentos.add(new FragmentoLetra("que ya nadie nos calla, ya nada nos contiene", 114.1, 123.0));
}

// --------- DRAW ------------
void draw() {
  if (!botonPresionado) {
    background(0, 0, 50);
    botonInicio.dibujar();
  } else {
    float tiempo = cancion.position();
    letraCancion = "";
    boolean mostrarFondoAzul = false;

    for (FragmentoLetra frag : fragmentos) {
      if (frag.estaActivo(tiempo)) {
        letraCancion = frag.getTextoParcial(tiempo);
        if (frag.texto.equals("que ya nadie nos calla, ya nada nos contiene")) {
          mostrarFondoAzul = true;
        }
        break;
      }
    }

    if (tiempo < 45) {
      escena = 1;
      tiempoInicioEscena0 = -1;
    } else if (tiempo < 75) {
      escena = 2;
      tiempoInicioEscena0 = -1;
    } else if (tiempo < 108) {
      escena = 3;
      tiempoInicioEscena0 = -1;
    } else {
      escena = 0;
      if (tiempoInicioEscena0 < 0) {
        tiempoInicioEscena0 = tiempo;
      }
    }

    if (escena == 1) {
      background(0, 0, 50);
      float t = map(tiempo, 0, 45, 0, 1);
      t = constrain(t, 0, 1);
      tint(255, 255 * (1 - t));
      image(hojas, 0, 0, width, height);
      tint(255, 255 * t);
      image(hojas2, 0, 0, width, height);
      noTint();
    } else if (escena == 2) {
      background(0, 0, 50);
      image(cieloEstrellado, 0, 0, width, height);
      for (int i = 0; i < estrellas.length; i++) {
        float parpadeo = sin(frameCount * 0.05 + i) * 80 + 175;
        fill(255, parpadeo);
        noStroke();
        ellipse(estrellas[i].x, estrellas[i].y, 2, 2);
      }

      if (circuloSizeRojo < 400) {
        circuloSizeRojo += 1.5;
      }
      noStroke();
      fill(255, 0, 0, 180);
      ellipse(width/2 - 50, height/2 + 50, circuloSizeRojo, circuloSizeRojo);

      if (circuloSizeAzul < 400) {
        circuloSizeAzul += 1.2;
      }
      fill(0, 0, 255, 180);
      ellipse(width/2 + 50, height/2 + 50, circuloSizeAzul, circuloSizeAzul);
    } else if (escena == 3) {
      background(0, 0, 50);
      float tiempoEnEscena = tiempo - 75;
      float duracionEscena3 = 108 - 75;
      float alphaTierra = 255;
      if (tiempoEnEscena > duracionEscena3 * 0.7) {
        alphaTierra = map(tiempoEnEscena, duracionEscena3 * 0.7, duracionEscena3, 255, 0);
        alphaTierra = constrain(alphaTierra, 0, 255);
      }
      tint(255, alphaTierra);
      image(tierra, 0, 0, width, height);
      noTint();

      for (Flor f : flores) {
        f.dibujar();
      }

      if (mostrarSemilla && !semillaClickeada) {
        image(semillaImg, width/2 - 25, height/2 - 25, 50, 50);
      }

      if (semillaClickeada) {
        image(raicesImg, width/2 - 50, height/2, 100, 100);
      }

      if (tiempo >= 94.6) {
        if (tiempo - tiempoUltimaFlor > intervaloFlor && indiceFlor < floresImgs.length) {
          tiempoUltimaFlor = tiempo;
          indiceFlor++;
          opacidadFlor = 0;
          mostrandoFlor = true;
        }

        if (mostrandoFlor && indiceFlor > 0 && indiceFlor <= floresImgs.length) {
          opacidadFlor += 255 / (duracionFade * 60);
          opacidadFlor = constrain(opacidadFlor, 0, 255);
          float tiempoDesdeFlor = tiempo - tiempoUltimaFlor;
          float alphaFlor = opacidadFlor;
          if (tiempoDesdeFlor > duracionFade) {
            alphaFlor = map(tiempoDesdeFlor, duracionFade, duracionFade + intervaloFlor, 255, 0);
            alphaFlor = constrain(alphaFlor, 0, 255);
          }

          tint(255, alphaFlor);
          image(floresImgs[indiceFlor - 1], 0, 0, width, height);
          noTint();
        }
      }
    } else if (escena == 0) {
      float tiempoEscena0 = tiempo - tiempoInicioEscena0;

      if (tiempoEscena0 < 4) {
        background(0);
        image(semillaImg, width/2 - semillaImg.width/2, height/2 - semillaImg.height/2);
      } else if (tiempoEscena0 < 8) {
        background(0);
        image(raicesImg, width/2 - raicesImg.width/2, height/2 - raicesImg.height/2);
      } else {
        background(0, 0, 50);
      }
    }

    // --- Letra animada con círculo naranja ---
    if (letraCancion.length() > 0) {
      float targetCirculoSize = map(letraCancion.length(), 0, 50, 50, 200);
      fill(255, 165, 0, 180);
      noStroke();
      ellipse(width / 2, height / 2, targetCirculoSize, targetCirculoSize);

      fill(255);
      textSize(32);
      textAlign(CENTER, CENTER);
      text(letraCancion, width / 2, height / 2);
    }
  }
}
void mousePressed() {
  // Detectar clic en el botón de inicio
  if (!botonPresionado && botonInicio.fuePresionado(mouseX, mouseY)) {
    botonPresionado = true;
    cancion.play();
    mostrarSemilla = true;
  }

  // Detectar clic en la semilla
  if (mostrarSemilla && !semillaClickeada) {
    float d = dist(mouseX, mouseY, width / 2, height / 2);
    if (d < 25) {
      semillaClickeada = true;
    }
  }
}
