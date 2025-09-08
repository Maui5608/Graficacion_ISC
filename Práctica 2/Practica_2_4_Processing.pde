float[] valores = {25.0, 45.0, 5.0, 15.0, 10.0};

void setup() {
  size(350, 400); // ancho x alto
  background(0);
  dibujaGraficoBarras(valores);
  
  // Ejes
  stroke(255);
  strokeWeight(5);
  line(0, height, width, height); // eje X
  line(0, 0, 0, height);          // eje Y
}

void dibujaGraficoBarras(float[] datos) {
  int n = datos.length;
  float anchoBarra = width / n;
  float maxValor = max(datos);

  for (int i = 0; i < n; i++) {
    float altura = map(datos[i], 0, maxValor, 0, height);
    float x = i * anchoBarra;
    float y = height - altura;

    // Color aleatorio
    fill(random(255), random(255), random(255));
    noStroke();
    rect(x, y, anchoBarra, altura); // uso completo del ancho
  }
}
