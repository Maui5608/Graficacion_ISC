float[] valores = {25.0, 45.0, 5.0, 15.0, 10.0};  // Suma 100%

void setup() {
  size(640, 360);
  noStroke();
  noLoop();  // Ejecuta el codigo una vez
}

void draw() {
  background(0);
  pieChart(width/2, height/2, 150, valores);  // Centro y radio del circulo
}

void pieChart(float cx, float cy, float radio, float[] data) {
  float lastAngulo = 0;
  for (int i = 0; i < data.length; i++) {
    // Color aleatorio para cada segmento
    fill(random(255), random(255), random(255));
    
    // Convertir porcentaje a ángulo en radianes
    float angulo = radians(data[i] * 360 / 100.0);
    
    // Dibujar arco
    arc(cx, cy, radio * 2, radio * 2, lastAngulo, lastAngulo + angulo);
    
    lastAngulo += angulo;
  }
}
