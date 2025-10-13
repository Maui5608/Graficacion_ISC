// Practica 5-3: el sol tambien orbita (sistema jerárquico)

// Ángulo, velocidad y radio de la órbita del SOL
float angSol = 0;      // ángulo actual del sol
float velSol = 0.01;   // velocidad angular del sol
float rSol  = 40;      // radio de la órbita del sol (respecto al centro de la pantalla)

// Variables de ángulos iniciales de planetas y lunas
float angP1=0, angP2=PI/3, angP3=2*PI/3, angL1=0, angL2=PI;
// Velocidades angulares de cada planeta/luna
float velP1=0.10, velP2=0.05, velP3=0.025, velL1=0.10, velL2=0.05;

void setup(){
  size(500, 500);       // Tamaño de la ventana   
}

void draw(){
  background(0);               // Fondo negro (espacio)
  translate(width/2,height/2); // Coloca el origen en el centro de la pantalla

  // --- Dibuja la órbita del sol ---
  stroke(80);          // Contorno gris tenue para la órbita
  noFill();            // Solo contorno, sin rellenar
  ellipse(0,0, rSol*2, rSol*2); // Circunferencia con radio rSol

  // --- SISTEMA RELATIVO AL SOL ---
  pushMatrix();                  // Guarda el sistema de coordenadas global
  rotate(angSol += velSol);      // Gira alrededor del centro (avance de ángulo del sol)
  translate(rSol, 0);            // Traslada al sol hasta su posición en la órbita

  // --- Sol ---
  noStroke();                    // Sin contorno para disco sólido
  fill(241,250,3);               // Amarillo brillante para el sol
  ellipse(0,0, 26,26);           // Dibuja el sol en su posición actual

  // A partir de aquí, todo se dibuja "relativo" a la posición del sol
  // Es decir, si el sol se mueve, los planetas y lunas se mueven "con él"

  // --- Radios orbitales de los planetas ---
  float r1 = 70, r2 = 120, r3 = 170;
  stroke(80);                      // Restaura el contorno gris
  noFill();                        // Las órbitas son solo círculos vacíos
  
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

  popMatrix();                   // <- MUY IMPORTANTE: cerramos el sistema relativo al sol
  // A partir de aquí se vuelve al sistema centrado en pantalla,
  // sin las transformaciones del sol y sus planetas.
}
