

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

int x = 0;
int baseY = 350; // Punto medio para la curva
float rad;
color bgColor = color(255, 247, 173); // #FFF7AD
color[] colors = {color(245, 42, 83), color(255, 23, 201), color(235, 101, 250)}; // #F52A53, #FF17C9, #EB65FA

void setup() {
  size(900, 700);
  background(bgColor); // Fondo en color #FFF7AD

  minim = new Minim(this);
  player = minim.loadFile("time.mp3", 1024);
  player.play();

  fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {
  fft.forward(player.left);

  float level = fft.getBand(10); 

  strokeWeight(4); // Grosor del contorno
  color currentColor = colors[int(random(colors.length))]; 
  
  if (currentColor == color(245, 42, 83)) { // #F52A53
    fill(245, 42, 83); 
  } else if (currentColor == color(255, 23, 201)) { // #FF17C9
    fill(39, 3, 252); // #2703FC
  } else { // #EB65FA
    fill(255, 10);
  }

  stroke(currentColor);
  
  rad = (level * (width / 50)); // Tamaño del círculo
  int y = baseY + int(sin(frameCount * 0.05) * 100); // Movimiento en curva
  
  ellipse(x, y, rad, rad);

  x += 5; // Avanza en el eje X

  if (x > width) {
    x = 0;
    background(bgColor); // Mantiene el fondo #FFF7AD
  }
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
