void setup() {
  size(500, 500); // Tamaño de la ventana
  background(255); // Fondo blanco
  stroke(0); // Color del trazo: negro
  noFill(); // Sin relleno en el polígono

  // Ejemplo: polígono centrado en (250, 250), radio 100, con 5 lados
  poligonShape(250, 250, 100, 5);
}

void poligonShape(int cx, int cy, int r, int n) {
  float anguloV = TWO_PI / n; // Ángulo entre vértices

  beginShape(); // Inicia forma libre

  for (int i = 0; i < n; i++) {
    float angulo = i * anguloV;
    float x = cx + r * cos(angulo);
    float y = cy + r * sin(angulo);
    vertex(x, y); // Añade vértice
  }

  endShape(CLOSE); // Cierra la figura
}
