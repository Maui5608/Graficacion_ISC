// ================================
// Ejemplo de ambiente 3D con iluminación, sombreado y relleno
// ================================

void setup() { 
  // --- AMBIENTE 3D ---
  // Se activa el renderizador P3D para trabajar en tres dimensiones (x, y, z)
  size(640, 360, P3D);
  
  // Se desactiva el trazo de bordes para que solo se aprecie el color de las caras (relleno)
  noStroke();
}

void draw() {
  // Fondo negro para resaltar los efectos de luz y sombra
  background(0);
  
  // --- TRANSFORMACIONES 3D ---
  // Se traslada el origen de coordenadas al centro de la pantalla
  translate(width / 2, height / 2);
  
  // --- ILUMINACIÓN ---
  // 1. Luz puntual (point light): simula una bombilla o fuente localizada
  //    Se usa color naranja y se coloca a la derecha del objeto
  pointLight(150, 100, 0,   // Color (RGB)
             200, -150, 0); // Posición (x, y, z)

  // 2. Luz direccional (directional light): simula luz del sol o fuente lejana
  //    Proyecta rayos paralelos desde la izquierda hacia el objeto
  directionalLight(0, 102, 255, // Color (azul)
                   1, 0, 0);    // Dirección (en eje x positivo)

  // 3. Luz tipo foco (spot light): ilumina en forma de cono con ángulo y concentración
  //    Se coloca al frente, color amarillo, con dirección y ángulo definidos
  spotLight(255, 255, 109, // Color (amarillo)
            0, 40, 200,    // Posición del foco
            0, -0.5, -0.5, // Dirección hacia abajo y atrás
            PI / 2, 2);    // Ángulo y concentración del haz
  
  // --- ROTACIONES 3D ---
  // Permiten ver el objeto desde diferentes ángulos moviendo el mouse
  rotateY(map(mouseX, 0, width, 0, PI));  // Rotación en eje Y
  rotateX(map(mouseY, 0, height, 0, PI)); // Rotación en eje X
  
  // --- OBJETO 3D CON SOMBREADO Y RELLENO ---
  // Dibuja un cubo (box) sólido de 150px de lado.
  // El relleno y las sombras varían según la iluminación aplicada.
  box(150);
}
