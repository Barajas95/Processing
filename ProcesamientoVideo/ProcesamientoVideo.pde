import processing.video.*;

PImage img;
int angulo = 0;
Capture c;

void setup() {
  size(800, 600, P3D);
  img = loadImage("doggo.jpg");
  
  String[] cameras = Capture.list();
  for(int i = 0; i < cameras.length; i++){
    println(i + " :: " + cameras[i]);
  }
  
  c = new Capture(this, cameras[37]);
  c.start();
}

void draw() {
  //background(0);
  noStroke();
  
  if(c.available()){
    c.read();
    background(0);
    translate(330, 230);
    
    rotateY(radians(angulo));
    angulo += 5;
    c.loadPixels();
    for(int i = 0; i < c.width; i++){
      for(int j = 0; j < c.height; j++){
        int k = i + j * c.width;
        
        pushMatrix();      
        fill(c.pixels[k]);
        
        float r = red(c.pixels[k]);
        float g = green(c.pixels[k]);
        float b = blue(c.pixels[k]);
        float gris = (r+g+b)/3;
        
        translate(i, j, gris);
        box(1);
        popMatrix();
      }
    }  
  }
}