import processing.video.*;

Capture c;
PImage img;
int modo = 0;
int bandera = 0;

void setup()
{
  size(800, 600, P3D);

  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++)
  {
    println(i + " :: " + cameras[i]);
  }

  c = new Capture(this, cameras[4]);
  c.start();
}

void draw()
{
  noStroke();
  //if(c.available()) //No funciona en mi conputadora si pongo esta linea de codigo
  if (true)
  {
    c.read();
    background(0);
    translate(350, 250);
    c.loadPixels();
    for (int i = 0; i < c.width; i++)
    {
      for (int j = 0; j < c.height; j++)
      {
        int k = i + j * c.width;
        pushMatrix();
//**********************************************************************************************
        //Modo normal
        if (modo == 0)
          fill(c.pixels[k]);
//**********************************************************************************************
        //Modo grises
        if (modo == 1)
        {
          float r = red(c.pixels[k]); float g = green(c.pixels[k]); float b = blue(c.pixels[k]);
          float gris = (r+g+b)/3;
          c.pixels[k] = color(gris, gris, gris);
          fill(c.pixels[k]);
        }
//**********************************************************************************************
        //Modo blanco y negro
        if (modo == 2)
        {
          float umbral = 90; //Variable que permite ajustar el nivel de blanco y negro. Entre mas grande mas negro
          float r = red(c.pixels[k]); float g = green(c.pixels[k]); float b = blue(c.pixels[k]);

          if (r > umbral && g > umbral && b > umbral)
            r = g = b = 255;
          else
            r = g = b = 0;

          c.pixels[k] = color(r, g, b);
          fill(c.pixels[k]);
        }
//**********************************************************************************************
        //Modo negativo
        if (modo == 3)
        {
          float r = red(c.pixels[k]); float g = green(c.pixels[k]); float b = blue(c.pixels[k]);
          c.pixels[k] = color(255 - r, 255 - g, 255 - b);
          fill(c.pixels[k]);
        }
//**********************************************************************************************
        //Modo diferencias
        if (modo == 4)
        {
          if (bandera == 0 )
          {
            bandera = 1;
            img = new PImage(c.width, c.height, RGB);
            for (int n = 0; n < c.width; n++)
            {
              for (int l = 0; l < c.height; l++)
              {
                int m = n + l * img.width;
                img.pixels[m] = c.pixels[m];
              }
            }
          }
          float rPrimero = red(img.pixels[k]);
          float gPrimero = green(img.pixels[k]);
          float bPrimero = blue(img.pixels[k]);
          float rActual = red(c.pixels[k]);
          float gActual = green(c.pixels[k]);
          float bActual = blue(c.pixels[k]);

          float promedio = (rPrimero + gPrimero + bPrimero) / 3;
          float promedio2 = (rActual + gActual + bActual) / 3;

          float rango = promedio2 - promedio;
          if (rango < 30)
            c.pixels[k] = color(rActual, gActual, bActual);
          else
            c.pixels[k] = color(0, 0, 0);
          fill(c.pixels[k]);
        }

        translate(i, j, 0);
        box(1);
        popMatrix();
      }
    }
  }
}

//**********************************************************************************************
void keyPressed(KeyEvent k)
{
  if (k.getKeyCode() == 49)  //Presionar tecla 1 para modo normal
  {
    modo = 0;
    bandera = 0;
  }
  if (k.getKeyCode() == 50) //Presionar tecla 2 para modo grises
  {
    modo = 1;
    bandera = 0;
  }
  if (k.getKeyCode() == 51) //Presionar tecla 3 para modo blanco y negro
  {
    modo = 2;
    bandera = 0;
  }
  if (k.getKeyCode() == 52) //Presionar tecla 4 para modo negativo
  {
    modo = 3;
    bandera = 0;
  }
  if (k.getKeyCode() == 53) //Presionar tecla 5 para modo diferencia
  {
    modo = 4;
  }
}