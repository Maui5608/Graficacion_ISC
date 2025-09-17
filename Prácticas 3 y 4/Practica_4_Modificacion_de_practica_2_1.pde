int w, h;

void setup() {
  size(480, 190);
  w = width;
  h = height;
  background(0); // Fondo negro
  
  //Linea del eje X
  stroke(255);
  strokeWeight(1);
  line(0,h/2,w,h/2);
  
  //Linea del eje Y
  stroke(255);
  strokeWeight(1);
  line(0,0,0,h);
  
  // Guardamos estado original de la matriz
  pushMatrix();
  
  // Cambiar el sistema de coordenadas:
  // Trasladamos el origen a (0, height/2) -> centro vertical
  // Escalamos en X para mapear [0, 2PI] a [0, width]
  // Escalamos en Y para mapear [-1, 1] a [height, 0] (invirtiendo eje Y)
  translate(0, h/2);
  scale(w / (2*PI), -h/2);
  
  // Dibujar seno en rojo
  stroke(255, 0, 0);
  strokeWeight(0.03);
  dibujarSeno();
  
  // Dibujar coseno en verde
  stroke(0, 255, 0);
  strokeWeight(0.03);
  dibujarCoseno();
  
  // Restaurar sistema de coordenadas original
  popMatrix();
}

void dibujarSeno() {
  float prevX = 0;
  float prevY = sin(0);
  for (float angulo = 0; angulo <= TWO_PI; angulo += 0.01) {
    float x = angulo;
    float y = sin(angulo);
    line(prevX, prevY, x, y);
    prevX = x;
    prevY = y;
  }
}

void dibujarCoseno() {
  float prevX = 0;
  float prevY = cos(0);
  for (float angulo = 0; angulo <= TWO_PI; angulo += 0.01) {
    float x = angulo;
    float y = cos(angulo);
    line(prevX, prevY, x, y);
    prevX = x;
    prevY = y;
  }
}
