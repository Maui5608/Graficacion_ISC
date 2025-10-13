// === Practica 7-4 — Basado en 7-2: bajorrelieve desde imagen ===
// Objetivo: convertir niveles de gris en altura suave (sin picos) y con grosor fino,
// parecido a la referencia (placa verde con rostro definido).

import processing.opengl.*;

// ----- Interacción -----
float rotX = 0.0, rotY = 0.0;       // rotación acumulada en X e Y
int lastX, lastY;                   // última posición del ratón presionado
float distX = 0.0, distY = 0.0;     // delta de arrastre (en radianes)

// ----- Configuración de la malla y su resolución -----
float zoom=-50;         // alejar cámara
float alturaZ=100;        // altura de los relieves
int steps=100;           //resolución
PImage img;              //imagen que se usara

void setup(){
  size(500,500,P3D);
  stroke(70, 200, 70);
  noFill();

  // --- Carga y preproceso de imagen ---
  img = loadImage("Ejemplo.jpg");      //cargar imagen
  img.resize(steps, steps);            //ajustarlo al tamaño de la malla
}

void draw() {
  background(0);
  
  // Iluminación básica (sombreado suave)
  ambientLight(90,90,90);
  directionalLight(215,215,215, -0.6,-0.5,-1);
  directionalLight(60,60,60,     0.4, 0.2, 1);

  translate(width/2, height/2, zoom);
  rotateX(rotX + distY);
  rotateY(rotY + distX);

  // Centramos el dibujo
  translate(-img.width*2, -img.height*2);
  
  // Dibujamos la superficie a partir de la imagen
  for (int y = 0; y < img.height-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < img.width; x++) {
      // Obtenemos el brillo del píxel actual y el de la fila de abajo
      float brillo1 = brightness(img.get(x, y));
      float brillo2 = brightness(img.get(x, y+1));

      // Mapeamos el brillo (0-255) a la altura en Z
      float z1 = map(brillo1, 0, 255, -alturaZ, alturaZ);
      float z2 = map(brillo2, 0, 255, -alturaZ, alturaZ);

      // Creamos los dos vértices para la tira de triángulos/cuadriláteros
      vertex(x*4, y*4, z1);
      vertex(x*4, (y+1)*4, z2);
    }
    endShape();
  }
}



// ----- Ratón para rotar -----
void mousePressed(){ lastX=mouseX; lastY=mouseY; }
void mouseDragged(){ distX=radians(mouseX-lastX); distY=radians(lastY-mouseY); }
void mouseReleased(){ rotX+=distY; rotY+=distX; distX=distY=0; }
