void setup(){
  background(0);   //Fondo negro
  size(250,400);   //Tamaño del lienzo
  
  //Crea un objeto tipo imagen llamado "image" 
  //Y con "loadImage()" carga la imagen en el objeto "imagen"
  PImage imagen = loadImage("C:Marca de agua_Maui y Shirley.jpeg");  
                                                        
  //Visualiza la imagen que tiene el objeto "imagen"
  image(imagen,0,50,250,300); 
}
