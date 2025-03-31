int catX = 50, catY = 300, catVelocity = 0;
boolean onGround = true, gameWon = false;
int gravity = 1, jumpStrength = -10;
int[][] boxes = {{150, 250}, {300, 200}, {450, 150}, {600, 100}};
int fishX = 650, fishY = 50;

void setup() {
  size(800, 400);
}

void draw() {
  background(135, 206, 235);
  fill(160, 82, 45);
  rect(0, 350, width, 50);
  
  for (int[] box : boxes) {
    rect(box[0], box[1], 50, 50);
  }
  
  fill(255, 215, 0);
  ellipse(fishX, fishY, 30, 20);
  
  fill(0);
  ellipse(catX, catY, 30, 30);
  
  if (!gameWon) {
    catY += catVelocity;
    catVelocity += gravity;
    onGround = catY >= 320;
    if (onGround) {
      catY = 320;
      catVelocity = 0;
    }
    
    for (int[] box : boxes) {
      if (catX >= box[0] && catX <= box[0] + 50 && catY + 15 >= box[1] && catY + 15 <= box[1] + 10) {
        catY = box[1] - 15;
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

void mousePressed() {
  if (onGround && !gameWon) {
    catVelocity = jumpStrength;
    onGround = false;
  }
}
