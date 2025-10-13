// === Practica 7-3 (a partir de tu 7-2) ===
// Superficie 3D con luces + color por altura (gradiente rojo -> amarillo)
import processing.opengl.*;

// ---------- Interacción ----------
float rotX=0, rotY=0; int lastX, lastY; float distX=0, distY=0;

// ---------- Resolución y escalas ----------
int steps = 50;                 // densidad de la malla
float scaleZ = 200;             // relieve (alto en Z)
float zoomZ  = -300;            // "acercar/alejar" en Z
float gX=500, gY=500;           // tamaño en píxeles de X e Y

// ---------- Rango de alturas para normalizar colores ----------
float minZ, maxZ;

// Función de la superficie en [0,1]x[0,1]
float funcion(float x, float y){
  return x*x*x + y*y*y;
}

void setup(){
  size(500,500,P3D);
  smooth(8);
  noStroke();                   // sin contorno para la malla
  // precalcula minZ y maxZ en el dominio [0,1]
  calcMinMax();
}

void draw(){
  background(0);

  // Iluminación básica (sombreado suave)
  ambientLight(90,90,90);
  directionalLight(215,215,215, -0.6,-0.5,-1);
  directionalLight(60,60,60,     0.4, 0.2, 1);

  // Encadre y rotaciones (idéntico a 7-2)
  translate(gX/2, gY/2, zoomZ);
  rotateY(rotY + distX);
  rotateX(rotX + distY);
  translate(-gX/2, -gY/2);

  // ======= Superficie con color por vértice =======
  pushMatrix();
    scale(gX, gY, scaleZ);

    // Al usar color por vértice, el "material" lo define fill() antes de cada vertex
    noStroke();
    specular(40);  // opcional: pequeño especular para que las luces se noten
    shininess(6);

    dibujarFuncionGradiente(); // QUAD_STRIP con fill() distinto en cada vértice
  popMatrix();

  // ======= (Opcional) Ejes largos anclados en la esquina sup-izq =======
  float ax=0, ay=0;
  float axPix=ax*gX, ayPix=ay*gY, azPix=funcion(ax,ay)*scaleZ;
  strokeWeight(2);
  stroke(255,0,0);   line(axPix,ayPix,azPix, axPix+900,ayPix,azPix);     // X
  stroke(0,255,0);   line(axPix,ayPix,azPix, axPix,ayPix+900,azPix);     // Y
  stroke(0,90,255);  line(axPix,ayPix,azPix, axPix,ayPix,azPix+900);     // Z
}

// Emite la malla con color por vértice según altura normalizada
void dibujarFuncionGradiente(){
  float in_steps = 1.0/steps;

  // Recorremos por franjas en Y usando QUAD_STRIP
  for (int j=0; j<steps; j++){
    float y  = j*in_steps;
    float y2 = (j+1)*in_steps;

    beginShape(QUAD_STRIP);
    for (int i=0; i<=steps; i++){
      float x = i*in_steps;

      // Vértice 1 (fila j)
      float z1 = funcion(x, y);
      float t1 = map(z1, minZ, maxZ, 0, 1);  // normaliza a 0..1
      fill( lerpColor(color(255,0,0), color(255,255,0), t1) );
      vertex(x, y, z1);

      // Vértice 2 (fila j+1)
      float z2 = funcion(x, y2);
      float t2 = map(z2, minZ, maxZ, 0, 1);
      fill( lerpColor(color(255,0,0), color(255,255,0), t2) );
      vertex(x, y2, z2);
    }
    endShape();
  }
}

// Calcula minZ y maxZ de la función en una rejilla (para normalizar color)
void calcMinMax(){
  minZ =  1e9;
  maxZ = -1e9;
  float in_steps = 1.0/steps;
  for (int j=0; j<=steps; j++){
    float y = j*in_steps;
    for (int i=0; i<=steps; i++){
      float x = i*in_steps;
      float z = funcion(x,y);
      if (z<minZ) minZ=z;
      if (z>maxZ) maxZ=z;
    }
  }
}

// Controles de rotación (como en tu 7-2)
void mousePressed(){ lastX=mouseX; lastY=mouseY; }
void mouseDragged(){ distX=radians(mouseX-lastX); distY=radians(lastY-mouseY); }
void mouseReleased(){ rotX+=distY; rotY+=distX; distX=distY=0; }
