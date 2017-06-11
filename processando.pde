PImage org, crip;

void setup()
{
 int num, aux, a;
 int[] vec = new int[15];
 crip = loadImage("criptogragada.bmp");
 org = loadImage("original.bmp");
 crip.loadPixels();

 for (int i = 0;  i < 15; i++)
 {
  num = crip.pixels[i];
  num = -num;
  aux = num/1000000;
  aux *= 1000000;
  num %= aux;
  a = (num & 0x10101);
  vec[i] = a;
  println(binary(vec[i]));
  }
 }
/*void draw()
{  
}*/