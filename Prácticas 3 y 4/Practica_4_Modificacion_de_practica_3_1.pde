void setup() {
  size(400, 400);
  background(0);
  
  // Cargar imagen
  PImage imagen = loadImage("C:Marca de agua_Maui y Shirley.jpeg");
  
  // Calcular escalado proporcional
  float escalaX = width / float(imagen.width);
  float escalaY = height / float(imagen.height);
  
  // Factor de escala global
  float escala = min(escalaX, escalaY);
  
  // Centrar imagen
  float nuevaW = imagen.width * escala;  //Nuevas dimensiones
  float nuevaH = imagen.height * escala;
  
  float posX = (width - nuevaW) / 2;     //Posiciones posX y posY
  float posY = (height - nuevaH) / 2;
  
  // Dibujar con transformaciones
  pushMatrix();
  translate(posX, posY);
  scale(escala);
  image(imagen, 0, 0);
  popMatrix();
}
