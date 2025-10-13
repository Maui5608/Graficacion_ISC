// Practica 7-1: cubo interactivo con zoom (UP/DOWN)

float rotX=0, rotY=0, distX=0, distY=0; // variables para rotación
int lastX, lastY;                       // almacenan la última posición del ratón
float zCam = 0;                         // posición de la cámara en Z (0 cerca, -500 lejos)

void setup(){
  size(300,300,P3D);   // Lienzo 3D
  noStroke(); 
  fill(255,0,0); // Cubo rojo sin contorno
}

void draw(){
  background(0);               // Fondo negro
  lights();                    // Luces básicas para dar volumen
  translate(width/2, height/2, zCam); // centra el cubo y aplica zoom con zCam
  rotateX(rotX + distY);       // rota en eje X (vertical)
  rotateY(rotY + distX);       // rota en eje Y (horizontal)
  box(100,100,100);            // dibuja cubo de 100 px
}

// Guarda la posición inicial del ratón cuando se hace click
void mousePressed()
{ 
  lastX = mouseX; 
  lastY=mouseY; 
}

// Calcula el desplazamiento del ratón en píxeles y lo convierte a radianes
void mouseDragged(){ 
  distX = radians(mouseX-lastX); 
  distY = radians(lastY-mouseY); 
}

//Cuando se suelta, acumula la rotación en rotX/rotY y resetea distancias
void mouseReleased()
{
  rotX += distY;
  rotY += distX;
  distX = distY = 0.0;
}

// Con UP/DOWN modificamos zCam para acercar/alejar la cámara
void keyPressed(){
  if (key == CODED){
    if (keyCode == UP)   zCam = min(0, zCam + 10);      // acercar
    if (keyCode == DOWN) zCam = max(-500, zCam - 10);   // alejar
  }
}
