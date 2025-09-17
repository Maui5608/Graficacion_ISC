PImage img;
int[] histograma = new int[256];
int histogramaMax = 0;

void setup() {
  size(300,500); // Tamaño total de la ventana
  img = loadImage("C:Ejemplo.jpg"); // Imagen
  img.filter(GRAY); // Convertir a escala de grises
  
  calcularHistograma(); //LLamado de la función que calcula el histograma
}

void draw() {
  background(0); // Fondo negro

  // Mostrar imagen en la parte superior
  image(img, 0, 0, width, height - 110);

  // Dibujar histograma en la parte inferior
  dibujarHistograma();
}

void calcularHistograma() {
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int brillo = int(red(img.get(x, y))); // Valor de gris
      histograma[brillo]++;
      if (histograma[brillo] > histogramaMax) {
        histogramaMax = histograma[brillo];
      }
    }
  }
}

void dibujarHistograma() {
  int ubicacionX = 0;
  int ubicacionY = height - 100;
  int ancho = 256;
  int alto = 100;

  stroke(255); // Color blanco
  for (int i = 0; i < histograma.length; i++) {
    float x = map(i, 0, 255, ubicacionX, ubicacionX + ancho);
    float h = map(histograma[i], 0, histogramaMax, 0, alto);
    line(x, ubicacionY + alto, x, ubicacionY + alto - h);
  }
}
