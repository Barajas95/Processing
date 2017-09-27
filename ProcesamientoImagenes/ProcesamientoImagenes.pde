PImage img, img2, img3, img4;
float maximo = 30;
float a = 0.5f; 

void setup() {
  size(800, 600);
  img = loadImage("pupper.jpg");
  img2 = loadImage("doggo.jpg");
  img3 = new PImage(img2.width, img2.height, RGB);
  img4 = new PImage(img.width, img.height, RGB);
}

void draw() {
  
  img2.loadPixels();
  img3.loadPixels();
  
  // arreglo pixels es de 1 dimension
  for(int i = 0; i < img2.width - 1; i++){
    for(int j = 0; j < img2.height; j++){
      
      int k = i + j * img2.width;
      
      float vActual = green(img2.pixels[k]);
      float rActual = red(img2.pixels[k]);
      float aActual = blue(img2.pixels[k]);
      
      float promedio = (rActual + vActual + aActual)/3;
      
      int k2 = k + 1;
      float promedio2 = (red(img2.pixels[k2]) + 
                          green(img2.pixels[k2]) + 
                          blue(img2.pixels[k2]))/3;
      
      if(abs(promedio - promedio2) > maximo){
        img3.pixels[k] = color(255, 0, 0);
      } else {
        img3.pixels[k] = color(0, 0, 0);
      }
      //img2.pixels[k] = color(promedio, promedio, promedio);
      
      /*
      float vActual = green(img2.pixels[i]);
      float rActual = red(img2.pixels[i]);
      float aActual = blue(img2.pixels[i]);
    
      img2.pixels[i] = color(rActual, 0, aActual);*/
    }
  }
  
  img3.updatePixels();
  
  
  img.loadPixels();
  img4.loadPixels();
  
  for(int i = 0; i < img.width; i++){
    for(int j = 0; j < img.height; j++){
      
      int k = i + j * img.width;
      
      if(i >= img2.width || j >= img2.height){
        img4.pixels[k] = img.pixels[k];
      } else {
        
        int k2 = i + j * img2.width;
        
        float nuevoR = red(img.pixels[k]) * (1 - a) + red(img2.pixels[k2]) * a;
        float nuevoG = green(img.pixels[k]) * (1 - a) + green(img2.pixels[k2]) * a;
        float nuevoB = blue(img.pixels[k]) * (1 - a) + blue(img2.pixels[k2]) * a;
        img4.pixels[k] = color(nuevoR, nuevoG, nuevoB);
      }
    }
  }
  
  
  img4.updatePixels();
  image(img4, 0, 0);
  //image(img, 0, 0);
  //image(img2, 0, 0);
  image(img3, 500, 100);
}