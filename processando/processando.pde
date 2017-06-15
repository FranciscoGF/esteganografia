PImage crip; //declara uma variável do tipo PImage, para a imagem criptografada

int separa(int p1)//inicializa uma função que recebe um pixel e devolve ele somente com os bits menos significativos
{
  int p1_g, p1_r, p1_b, res; //declara as variaveis dos pixeis verde, vermelho e azul
  p1 = p1 & 0x10101;         //usa uma máscara que mostra só os bits menos significativos 
  p1_b = (p1 & 0x1);         //essa e as duas próximas linhas são usadas para retirar os espaços entre os bits menos significativos
  p1_g = (p1 & 0x100)>>7;
  p1_r = (p1 & 0x10000)>>14;
  res = p1_b | p1_r | p1_g;  //retorna um valor só com os bits menos significativos
  return res;
}

int concatena(int p1, int p2, int p3) //inicializa uma função que concatena 3 pixels em uma valor só
{
  int res;
  res = (p1<<6)|(p2<<3)|p3;        //concatena os 3 pixels
  return (res&(0xff>>1));          //usa uma máscara para retirar o bit em excesso e retorna o bit concatenado
}

void setup()
{
 int X_1, X_2, X, Y_1, Y_2, Y, dir, chara = 1, inicial, i = 0; //variável i iniciada em zero para poder somar com o valor inicial e percorrer todo o texto
 String mensagem = "";                                          //inicializa uma variável do tipo string e define ela como um "texto vazio", com nada entre as aspas
 crip = loadImage("criptogragada.bmp");                         //carrega a imagem "criptogragada.bmp" dentro da variável crip
 crip.loadPixels();                                             //inicializa os pixels da variável para que possam ser acessados
 //0x10101 é a mascara dos menos significativos
 Y_1 = concatena(separa(crip.pixels[0]), separa(crip.pixels[1]), separa(crip.pixels[2]));    //concatena os pixels que indicam a coordenada de Y
 Y_2 = concatena(separa(crip.pixels[3]), separa(crip.pixels[4]), separa(crip.pixels[5]));    
 Y = Y_1 | Y_2 << 8; //junta os dois pixels concatenados para obter a posição de Y, onde a mensagem começa
 println("Y ->", Y);  //mostra a cordenada Y do inicio da mensagem
 X_1 = concatena(separa(crip.pixels[6]), separa(crip.pixels[7]), separa(crip.pixels[8])); //concatena os pixels que indicam a cooordenada de X
 X_2 = concatena(separa(crip.pixels[9]), separa(crip.pixels[10]), separa(crip.pixels[11]));
 X = X_1 | X_2 << 8; //junta os dois pixels concatenados
 println("X ->",X); //mostra a coordenada de X
 dir = concatena(separa(crip.pixels[12]), separa(crip.pixels[13]), separa(crip.pixels[14])); //concatena os pixels que indicam a direção de leitura
 println("direção ->",dir);//mostra a direção de leitura
 inicial = crip.width * Y + X; //como os pixels são armazenados em um só vetor, a posição inicial dos pixels é dada pela largura da imagem, multiplicado pelo valor de Y e somado com X
 do{
   chara = concatena(separa(crip.pixels[inicial+i]), separa(crip.pixels[inicial+i+1]), separa(crip.pixels[inicial+i+2])); //encontra o caractere da mensagem
   mensagem += ""+char(chara); //adiciona o caractere encontrado na variável do texto
   i+=3; //soma 3 para trabalhar com os próximos valores de i e percorrer todo o texto
 }while (chara != 0); //enquanto não for encontrado um character null ele continua percorrendo a mensagem
 println(mensagem); //mostra a mensagem
}

/*A mensagem obtida é:

?x88A senha para acesso ao sistema XY120BX

*/