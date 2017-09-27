//PROGRAMANDO UN BITRI

import controlP5.*;

ControlP5 cp5;
float ancho = 10;
float alto = 100;
float angulo = 0;

//Funciona solo una vez.
void setup()
{
  cp5 = new ControlP5(this);
  cp5.addSlider("bitri").setPosition(10,10).setSize(150,10).setRange(0,180).setValue(30).setNumberOfTickMarks(10);
  
  size(800,600);
}

//Metodo que se repide mientras se ejecuta el sketch
void draw()
{
  background(0);
  noStroke();
  
  //Bloque push-pop. Aislar transformaciones
  pushMatrix();
  
  //Transformacion -- modifica forma o ubicacion del objeto
  translate(320,240);
  /*
  rect(0,0,10,100);
  
  pushMatrix();
  rotate(radians(-30)); //Cuestion logica: trasladar y rotar. Cuestion programada: rotar y trasladar
  translate(0,-45);
  rect(0,0,5,50);
  popMatrix();
  
  pushMatrix();
  rotate(radians(30));
  translate(5,-50);
  rect(0,0,5,50);
  popMatrix();
  */
  arbol(1);
  
  popMatrix();
}

void arbol(float nivel)
{
  if(nivel > 10)
    return;
  
  float anchoN = ancho / nivel;
  float altoN = alto / nivel;
  
  float anchoF = ancho/(nivel+1);
  float altoF = alto/(nivel+1);
  
  rect(0,0,anchoN,altoN);
  
  pushMatrix();
  rotate(radians(-angulo)); //Cuestion logica: trasladar y rotar. Cuestion programada: rotar y trasladar
  translate(0,-altoF * 0.9f);
  arbol(nivel + 1);
  popMatrix();
  
  pushMatrix();
  rotate(radians(angulo));
  translate(anchoF,-altoF * 0.9f);
  arbol(nivel + 1);
  popMatrix();
}

void bitri(float v) //Imprimir valor del slider
{
  println("Valor: " + v);
  angulo = v;
}

void keyPressed(KeyEvent k) //Imprimir valor de la tecla presionada
{
  println(k.getKeyCode());
}