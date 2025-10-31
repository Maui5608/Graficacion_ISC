// Circulo móvil minimal con choque/contador y sombreado
float x=200, y=200, r=40, v=10;
color col = 0;
int choques=0;

void setup(){
  size(400,400);
  textFont(createFont("Arial Black",15));
  smooth(8);
}

void draw(){
  background(255);

  // Movimiento con flechas (interacción por variables del sistema)
  if (keyPressed){
    if (keyCode==LEFT)  x-=v;
    if (keyCode==RIGHT) x+=v;
    if (keyCode==UP)    y-=v;
    if (keyCode==DOWN)  y+=v;
  }

  // Límites + cambio de color y conteo
  boolean hit=false;
  if (x-r<0){x=r;hit=true;}
  if (x+r>width){x=width-r;hit=true;}
  if (y-r<0){y=r;hit=true;}
  if (y+r>height){y=height-r;hit=true;}
  if (hit){ choques++; col=color(random(40,255),random(40,255),random(40,255)); }

  // Sombreado rápido (gradiente radial + brillo)
  noStroke();
  int n=50;
  color cIn = lerpColor(col, color(255), 0.55);
  color cOut= lerpColor(col, color(0),   0.25);
  for (int i=n; i>0; i--){
    float t=i/(float)n, rr=r*t;
    fill(lerpColor(cIn, cOut, 1-t));
    ellipse(x, y, rr*2, rr*2);
  }
  fill(255,200);                    // “brillo” especular
  ellipse(x-r*0.35, y-r*0.35, r*0.6, r*0.6);

  // HUD
  fill(30);
  text("Choques: "+choques, 10, 30);
}
