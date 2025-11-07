// ================================
// Ambiente 3D con iluminación dinámica y cambio de color al hacer clic
// ================================

// Variables para colores de las luces
color pointColor, dirColor, spotColor;

void setup() { 
  // --- AMBIENTE 3D ---
  size(640, 360, P3D);
  noStroke();
  
  // Colores iniciales de las luces
  pointColor = color(150, 100, 0);   // Naranja
  dirColor   = color(0, 102, 255);   // Azul
  spotColor  = color(255, 255, 109); // Amarillo
}

void draw() {
  // Fondo negro para resaltar luces
  background(0);
  
  // --- TRANSFORMACIONES 3D ---
  translate(width / 2, height / 2);
  
  // --- ILUMINACIÓN ---
  // Luz puntual (simula una bombilla)
  pointLight(red(pointColor), green(pointColor), blue(pointColor),
             200, -150, 0);

  // Luz direccional (simula la luz solar)
  directionalLight(red(dirColor), green(dirColor), blue(dirColor),
                   1, 0, 0);

  // Luz tipo foco (haz cónico)
  spotLight(red(spotColor), green(spotColor), blue(spotColor),
            0, 40, 200,
            0, -0.5, -0.5,
            PI / 2, 2);
  
  // --- ROTACIONES 3D ---
  rotateY(map(mouseX, 0, width, 0, PI));
  rotateX(map(mouseY, 0, height, 0, PI));
  
  // --- OBJETO 3D ---
  box(150);
}

// --- EVENTO DE CLIC ---
void mousePressed() {
  // Cambiar los colores de las luces de forma aleatoria
  pointColor = color(random(255), random(255), random(255));
  dirColor   = color(random(255), random(255), random(255));
  spotColor  = color(random(255), random(255), random(255));
}
