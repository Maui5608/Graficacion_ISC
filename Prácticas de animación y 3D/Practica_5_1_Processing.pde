// Practica 5-1: n bolas rebotando

int n = 25;           // cantidad de bolas
float[] px, py;       // posiciones
float[] vx, vy;       // velocidades
int diam = 20;        // diametro de cada bola

void setup() {
  size(640, 360);
  noStroke();
  fill(255);
  
  px = new float[n];
  py = new float[n];
  vx = new float[n];
  vy = new float[n];
  for (int i = 0; i < n; i++) {
    px[i] = random(diam/2.0, width - diam/2.0);
    py[i] = random(diam/2.0, height - diam/2.0);
    vx[i] = random(-4, 4);
    vy[i] = random(-4, 4);
    if (abs(vx[i]) < 0.5) vx[i] = (random(1) < 0.5) ? -1 : 1;
    if (abs(vy[i]) < 0.5) vy[i] = (random(1) < 0.5) ? -1 : 1;
  }
}

void draw() {
  // efecto de rastro
  fill(0, 30);
  rect(0, 0, width, height);
  fill(255);

  for (int i = 0; i < n; i++) {
    // actualizar
    px[i] += vx[i];
    py[i] += vy[i];

    // colisiones con paredes
    float r = diam/2.0;
    if (px[i] + r > width)  { px[i] = width - r;  vx[i] *= -1; }
    if (px[i] - r < 0)      { px[i] = r;          vx[i] *= -1; }
    if (py[i] + r > height) { py[i] = height - r; vy[i] *= -1; }
    if (py[i] - r < 0)      { py[i] = r;          vy[i] *= -1; }

    // dibujar
    ellipse(px[i], py[i], diam, diam);
  }
}
