// Practica 5-2: sistema planetario con orbitas

// Variables de ángulos iniciales de planetas y lunas
float angP1=0, angP2=PI/3, angP3=2*PI/3, angL1=0, angL2=PI;
// Velocidades angulares de cada planeta/luna
float velP1=0.10, velP2=0.05, velP3=0.025, velL1=0.10, velL2=0.05;

void setup(){
  size(500, 500);       // Tamaño de la ventana
  stroke(180);          // Color gris para líneas (órbitas)
  noFill();             // Al inicio, no rellenar las órbitas
}

void draw(){
  background(0);        // Fondo negro simulando el espacio
  translate(width/2, height/2); // Centrar el sistema solar en la pantalla

  // --- Sol ---
  noStroke();                      // Quita el contorno para que el sol sea sólido
  fill(241,250,3);                 // Color del sol
  ellipse(0,0, 30,30);             // Dibuja el sol en el centro
  stroke(80);                      // Restaura el contorno gris
  noFill();                        // Las órbitas son solo círculos vacíos

  // --- Radios orbitales de los planetas ---
  float r1 = width*0.12, r2 = width*0.22, r3 = width*0.32;

  // --- Dibujar órbitas de referencia ---
  ellipse(0,0, r1*2, r1*2); // órbita del planeta 1
  ellipse(0,0, r2*2, r2*2); // órbita del planeta 2
  ellipse(0,0, r3*2, r3*2); // órbita del planeta 3

  // --- Planeta 1 ---
  pushMatrix();                 // Guarda sistema de coordenadas actual
  rotate(angP1 += velP1);       // Rota alrededor del centro según ángulo
  translate(r1, 0);             // Desplaza hasta el radio de su órbita
  noStroke(); fill(5,250,3);    // Color verde brillante
  ellipse(0,0, 16,16);          // Planeta como círculo sólido
  popMatrix();                  // Restaura coordenadas originales

  // --- Planeta 2 con lunas ---
  pushMatrix();
  rotate(angP2 += velP2);       // Rota en su órbita
  translate(r2, 0);             // Coloca planeta 2 en su radio
  noStroke(); fill(11,160,10);  // Color verde más oscuro
  ellipse(0,0, 16,16);          // Dibuja planeta 2

  // órbitas locales de sus lunas
  stroke(100); noFill();
  ellipse(0,0, 36,36); // órbita de luna 1
  ellipse(0,0, 60,60); // órbita de luna 2

  // --- Luna 1 ---
  pushMatrix();
  rotate(angL1 += velL1);       // Rota alrededor del planeta
  translate(18,0);              // Se aleja 18 píxeles del planeta
  noStroke(); fill(8,228,255);  // Color celeste
  ellipse(0,0, 6,6);            // Dibuja luna 1
  popMatrix();

  // --- Luna 2 ---
  pushMatrix();
  rotate(angL2 += velL2);       // Rota alrededor del planeta
  translate(30,0);              // Se aleja 30 píxeles del planeta
  noStroke(); fill(17,137,152); // Color azul verdoso
  ellipse(0,0, 6,6);            // Dibuja luna 2
  popMatrix();

  popMatrix();                  // Fin planeta 2 y sus lunas

  // --- Planeta 3 ---
  pushMatrix();
  rotate(angP3 += velP3);       // Rota en su órbita
  translate(r3, 0);             // Se coloca en su radio
  noStroke(); fill(7,88,6);     // Color verde oscuro
  ellipse(0,0, 16,16);          // Dibuja planeta 3
  popMatrix();
}
