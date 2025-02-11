// REPETICION
int size = 150;

void setup(){
  size(800,800);
  background(#E52E6F);
}

void draw(){
  noStroke();
  for (int x = 170; x < width; x += size*1.5){
    for (int y = 170; y < height; y += size*1.5){
      fill(#0748A2);
      ellipse(x, y, size, size);
      fill(#E52E6F);
      ellipse(x, y, size/2, size/2);
      fill(240,240,240);
      ellipse(x, y, size/3, size/3);
    }
  }
}
   
      
