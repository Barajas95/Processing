//PROGRAMANDO UN BITRI EN 3D

import controlP5.*;

ControlP5 cp5_1;
ControlP5 cp5_2;
float ancho = 10;
float alto = 100;
float anguloX = 0;
float anguloY = 0;
float anguloZ = 0;
float posicionVentanaX = 320;
float posicionVentanaY = 300;
float nivelRecursion = 5;
float nivelRamificacion = 3;

void setup()
{
  size(640, 480, P3D);
  cp5_1 = new ControlP5(this);
  cp5_2 = new ControlP5(this);
  cp5_1.addSlider("recursion").setPosition(10,10).setSize(150,10).setRange(1,10).setValue(5).setNumberOfTickMarks(10);
  cp5_2.addSlider("ramificacion").setPosition(10,40).setSize(150,10).setRange(2,6).setValue(3).setNumberOfTickMarks(5);
}

void draw()
{
  background(0);
  pushMatrix();
    translate(posicionVentanaX, posicionVentanaY, 0);
    rotateX(radians(anguloX));
    rotateY(radians(anguloY));
    rotateZ(radians(anguloZ));
    arbol(1);
  popMatrix();
}

void arbol(float nivel)
{
  if(nivel > nivelRecursion)
    return;
  
  float anchoN = ancho / nivel;
  float altoN = alto / nivel;
  float altoH = alto / (nivel + 1);  
  float desplazamiento = - (altoN - altoH) / 2;
  
  box(anchoN, altoN, anchoN); //Rectanguno 3D
  
  for(int i=0; i<nivelRamificacion; i++)
  {
    pushMatrix();
      translate(0, -altoH, 0);
      rotateY(radians((360/nivelRamificacion)*(i+1)));
      rotateX(radians(30));
      translate(0, desplazamiento, 0);
      arbol(nivel + 1);
    popMatrix();
  }  
}

void keyPressed(KeyEvent k)
{
// LETRA Q Y E para rotaciones en X
// LETRA A Y D para rotaciones en Y
// LETRA Z Y C para rotaciones en Z
  println(k.getKeyCode());
  if(k.getKeyCode() == 81) anguloX-=15;
  if(k.getKeyCode() == 69) anguloX+=15; 
  if(k.getKeyCode() == 65) anguloY-=15;
  if(k.getKeyCode() == 68) anguloY+=15; 
  if(k.getKeyCode() == 90) anguloZ-=15;
  if(k.getKeyCode() == 67) anguloZ+=15;
}

void mouseClicked()
{
  if (mouseButton == LEFT)
  {
    //Restringir ventana de Slider para el arbol
    if(pmouseX > 250 || pmouseY > 100)
    {
      posicionVentanaX = pmouseX;
      posicionVentanaY = pmouseY;
    }
  }
}

void recursion(float v)
{
  nivelRecursion = v;
}

void ramificacion(float v)
{
  nivelRamificacion = v;
}