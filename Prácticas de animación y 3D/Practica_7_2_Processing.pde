// === Practica 7-2 (basada en tu código original) ===

// Dibujo de una función 3D 
import processing.opengl.*;         // Soporte OpenGL (P3D usa OpenGL por debajo)

// ---------- Variables de interacción (rotación con el ratón) ----------
float rotX = 0.0, rotY = 0.0;       // rotación acumulada en X e Y
int lastX, lastY;                   // última posición del ratón presionado
float distX = 0.0, distY = 0.0;     // delta de arrastre (en radianes)

// ---------- Resolución y escalas ----------
int steps = 50;                     // resolución de la malla (cuantos quads por lado)
float scaleZ = 200.0;               // escala del relieve (altura Z)
float zoomZ  = -300.0;              // alejamiento de la "cámara" (translate en Z)
float gX = 500.0, gY = 500.0;       // tamaño "en píxeles" de la malla en X e Y

void setup() {
  size(500, 500, P3D);              // renderer P3D (3D)
  smooth(8);                        // antialiasing
  noStroke();                       // la superficie se dibuja sin contorno; lo activamos sólo para ejes
}

// ---------- Función de la superficie (x,y ∈ [0,1]) ----------
float funcion(float x, float y) {
  return x*x*x + y*y*y;             // curva suave; puedes cambiarla libremente
}

void draw() {
  background(0);                    // fondo negro

  // --- Iluminación: ambient + dos direccionales para sombreado suave ---
  ambientLight(90, 90, 90);         // luz ambiental (suaviza sombras)
  directionalLight(215,215,215, -0.6, -0.5, -1); // luz principal (arriba-izquierda)
  directionalLight(60,60,60,     0.4,  0.2,  1); // luz de relleno

  // --- Encadre y controles de vista ---
  translate(gX/2, gY/2, zoomZ);     // centra la escena y aplica "zoom" z
  rotateY(rotY + distX);            // rotación interactiva horizontal
  rotateX(rotX + distY);            // rotación interactiva vertical
  translate(-gX/2, -gY/2);          // vuelve a poner el (0,0) en la esquina superior-izquierda

  // ================== SUPERFICIE ==================
  pushMatrix();
    // Pasar de coordenadas normalizadas [0..1] a píxeles (gX,gY) y altura (scaleZ)
    scale(gX, gY, scaleZ);

    // Material: gris mate con un poco de componente especular
    noStroke();
    fill(175);                      // color base gris
    specular(40);                   // leve brillo
    shininess(6);                   // tamaño del "highlight"

    dibujarFuncion();               // emite la malla con QUAD_STRIP
  popMatrix();

  // ================== EJES FINOS ANCLADOS ==================
  // Dibujamos los ejes SIN scale(...) para que strokeWeight sea en píxeles reales.
  // Anclaje en la esquina SUPERIOR-IZQUIERDA de la malla: (ax=0, ay=0)
  float ax = 0.0, ay = 0.0;         
  float axPix = ax * gX;            // convertir a coordenadas de pantalla (porque no estamos escalando)
  float ayPix = ay * gY;
  float azPix = funcion(ax, ay) * scaleZ;

  strokeWeight(2);                  // grosor real (en píxeles de pantalla)

  // Eje X (rojo) — hacia +X (derecha). Lo hiciste largo (900 px) a propósito.
  stroke(255, 0, 0);
  line(axPix, ayPix, azPix,  axPix + 900, ayPix, azPix);

  // Eje Z (azul) — hacia +Z (hacia el observador). Largo (900 px).
  stroke(0, 90, 255);
  line(axPix, ayPix, azPix,  axPix, ayPix, azPix + 900);

  // Eje Y (verde) — hacia +Y (hacia abajo en pantalla). Largo (500 px).
  stroke(0, 255, 0);
  line(axPix, ayPix, azPix,  axPix, ayPix + 500, azPix);
}

// ---------- Construcción de la malla con tiras de cuadros ----------
void dibujarFuncion() {
  float x, y;
  int i, j;
  float in_steps = 1.0 / steps;     // paso uniforme en [0..1]

  // Precalcular las alturas z en una matriz (evita recalcular funcion(x,y) en cada vertex)
  float[][] matriz = new float[steps+1][steps+1];

  for (y = 0.0, j = 0; y <= 1.0; y += in_steps, j++) {
    for (x = 0.0, i = 0; x <= 1.0; x += in_steps, i++) {
      matriz[i][j] = funcion(x, y);
    }
  }

  // Emitir la superficie por franjas (QUAD_STRIP conecta pares de vértices)
  for (j = 0, y = 0.0; j < steps; j++, y += in_steps) {
    beginShape(QUAD_STRIP);
    for (i = 0, x = 0.0; i <= steps; i++, x += in_steps) {
      vertex(x, y,             matriz[i][j]);     // punto en fila j
      vertex(x, y + in_steps,  matriz[i][j+1]);   // punto en fila j+1
    }
    endShape();
  }
}

// ---------- Controles de rotación con el ratón ----------
void mousePressed() {
  lastX = mouseX; lastY = mouseY;   // almacena dónde empezó el arrastre
}
void mouseDragged() {
  // delta en píxeles convertido a radianes para rotación suave
  distX = radians(mouseX - lastX);
  distY = radians(lastY - mouseY);
}
void mouseReleased() {
  // acumula rotaciones y reinicia deltas
  rotX += distY; 
  rotY += distX;
  distX = distY = 0.0;
}
