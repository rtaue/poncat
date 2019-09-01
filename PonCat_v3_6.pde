import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim audio;
AudioPlayer meow1;
AudioPlayer meow2;
AudioPlayer musicaDeFundo;
AudioPlayer pong;
AudioPlayer beepMenu;
AudioPlayer beepBarreiras;
AudioPlayer beepScore;

PFont font;

String nome1 = "Rafael T. F. Pereira";
String nome2 = "Laís N. Rodrigues";
String ra1 = "RA20746682";
String ra2 = "RA20856043";

//VARIÁVEIS IMAGEM;
PImage menu;
PImage[] gameStart = new PImage[2];
PImage[] instrucoes = new PImage[2];
PImage fundoInstrucoes;
PImage bolinha;
PImage[] cat = new PImage[2];
PImage[] player = new PImage[2];
PImage[] voltarMenu = new PImage[2];
PImage[] end = new PImage[2];
PImage background;
PImage poteIMG;
PImage chinelosIMG;
PImage caixaAreiaIMG;
PImage caixaPapelaoIMG;
PImage spriteGatoDormindo;
PImage spriteGatoBrincando;

int[] quadro = new int[2];
int[] contador = new int[2];

int gameScreen = 0;

//VARIÁVEIS TIME;
int[] timer = new int[3];

//VARIÁVEIS TECLAS;
boolean left = false;
boolean right = false;
boolean A = false;
boolean D = false;
boolean enter = false;

//VARIÁVEIS PLAYER 1;
float player1X;
final float player1Y = 0;
float player1W;
final float player1H = 15;
float player1V;

//VARIÁVEIS PLAYER 2;
float player2X;
final float player2Y = 685;
float player2W;
final float player2H = 15;
float player2V;

//VARIÁVEIS BALL;
float ballX;
float ballY;
final float  ballW = 20;
final float  ballH = 20;
float vBallX;
float vBallY;

//VARIÁVEIS CAT;
float catX;
float catY;
float catW = 140;
float catH = 40;
float catV;
boolean preso = false;
boolean dormindo = false;
boolean miado = true;

//VARIÁVEIS CAIXA;
float caixaAreiaX;
float caixaAreiaY;
float caixaAreiaW = 114;
float caixaAreiaH = 80;
boolean caixaAreia = false;

float caixaPapelaoX;
float caixaPapelaoY;
float caixaPapelaoW = 104;
float caixaPapelaoH = 102;
boolean caixaPapelao = false;

//VARIÁVEIS POTE;
float poteX;
float poteY;
float poteW = 73;
float poteH = 70;
boolean pote = false;

//VARIÁVEIS CHINELOS;
float chinelosX;
float chinelosY;
float chinelosW = 97;
float chinelosH = 79;
boolean chinelos = false;

//VARIÁVEIS SCORE;
int score1;
int score2;
int score1Atual;
int score2Atual;

//VARIÁVEIS TEMPO;
int t;


void setup() {
  size(1000, 700);
  
  font = loadFont("TwCenMT-CondensedExtraBold-48.vlw");
  textFont(font);
  
  background = loadImage("background.png");
  bolinha = loadImage("bolinha.png");
  cat[0] = loadImage("gato1.png");
  cat[1] = loadImage("gato2.png");
  fundoInstrucoes = loadImage("fundoinstrucoes.png");
  menu = loadImage("titlebg.png");
  gameStart[0] = loadImage("gamestart1.png");
  gameStart[1] = loadImage("gamestart2.png");
  instrucoes[0] = loadImage("instrucoes1.png");
  instrucoes[1] = loadImage("instrucoes2.png");
  player[0] = loadImage("jogador1.png");
  player[1] = loadImage("jogador2.png");
  voltarMenu[0] = loadImage("voltaraomenu1.png");
  voltarMenu[1] = loadImage("voltaraomenu2.png");
  poteIMG = loadImage("potedecomida.png");
  chinelosIMG = loadImage("chinelos.png");
  caixaAreiaIMG = loadImage("caixadeareia.png");
  caixaPapelaoIMG = loadImage("caixapapelao.png");
  spriteGatoDormindo = loadImage("sprite_gato_dormindo.png");
  spriteGatoBrincando = loadImage("sprite_gato_brincando.png");
  end[0] = loadImage("telawinjogador1.png");
  end[1] = loadImage("telawinjogador2.png");
  
  audio = new Minim(this);
  meow1 = audio.loadFile("meow1.mp3");
  meow2 = audio.loadFile("meow2.mp3");
  musicaDeFundo = audio.loadFile("backgroundmusic.wav");
  beepMenu = audio.loadFile("beepMenu.aiff");
  beepBarreiras = audio.loadFile("beep_barreiras.mp3");
  pong = audio.loadFile("pong.aiff");
  beepScore = audio.loadFile("beepScore.aiff");
}

void draw() {
  if (musicaDeFundo.isPlaying() != true) musicaDeFundo.loop(0);
  if (gameScreen == 0) initScreen();
  else if (gameScreen == 1) instrScreen();
  else if (gameScreen == 2) gameScreen();
  else if (gameScreen == 3) endScreen();
}

//FUNÇÃO DAS TECLAS;
void keyPressed() {
  if (keyCode == LEFT) left = true;
  else if (keyCode == RIGHT) right = true;
  if (keyCode == 65) A = true;
  else if (keyCode == 68) D = true;
  if (keyCode == ENTER) enter = true;
}
void keyReleased() { 
  if (keyCode == LEFT) left = false;
  else if (keyCode == RIGHT) right = false;
  if (keyCode == 65) A = false;
  else if (keyCode == 68) D = false;
  if (keyCode == ENTER) enter = false;
}
void mousePressed() {
  beepMenu.play(0);
  if (gameScreen == 0) {
    if ((mouseX > 289 && mouseX < 716) && (mouseY > 333 && mouseY < 407)) {
      if (beepMenu.isPlaying() != true) beepMenu.play(0);
      gameScreen = 2;
    }
    if ((mouseX > 316 && mouseX < 689) && (mouseY > 463 && mouseY < 549)) {
      if (beepMenu.isPlaying() != true) beepMenu.play(0);
      gameScreen = 1;
    }
  }
  if (gameScreen == 1) {
    if ((mouseX > 377 && mouseX < 630) && (mouseY > 641 && mouseY < 684)) {
      if (beepMenu.isPlaying() != true) beepMenu.play(0);
      gameScreen = 0;
    }
  }
}

//FUNÇÕES DAS TELAS;
//Tela inicial/menu;
void initScreen() {
  image(menu, 0, 0);
  if ((mouseX > 289 && mouseX < 716) && (mouseY > 333 && mouseY < 407)) image(gameStart[1], 289, 333);
  else image(gameStart[0], 289, 333);
  if ((mouseX > 316 && mouseX < 689) && (mouseY > 463 && mouseY < 549)) image(instrucoes[1], 316, 463);
  else image(instrucoes[0], 316, 463);
  preparaJogo();
  fill(145, 130, 160);
  textAlign(LEFT);
  textSize(26);
  text(nome1 + " " + ra1, 10, 650);
  text(nome2 + " " + ra2, 10, 680);
}

//Tela de instrução;
void instrScreen() {
 image(fundoInstrucoes, 0, 0);
 if ((mouseX > 377 && mouseX < 630) && (mouseY > 641 && mouseY < 684)) image(voltarMenu[1], 377, 641);
 else image(voltarMenu[0], 377, 641);
}

//Tela de jogo;
void gameScreen() {
  timer[1]++;
  image(background, 0, 0);
  win();
  ball();
  player1();
  player2();
  cat();
  caixaAreia();
  pote();
  chinelos();
  caixaPapelao();
  tempo();
  score();
}

//Tela de endgame;
void endScreen() {
  String s1 = nf(score1, 2);
  String s2 = nf(score2, 2);
  if (score1 > score2 ) {
    image(end[0], 0, 0);
  } else {
    image(end[1], 0, 0);
  }
  textSize(72);
  fill(204, 51, 51);
  text(s1, 420, 320);
  fill(51, 153, 204);
  text(s2, 580, 320);
  fill(255);
  text("-", width/2, 320);
  if (enter) gameScreen = 0;
}

//OUTRAS FUNÇÕES;
//Função player1;
void player1() {
  image(player[0], player1X, player1Y);
  if (left && player1X > 0) player1X -= player1V;
  else if (right && (player1X + player1W) < width) player1X += player1V;
}

//Função player2;
void player2() {
  image(player[1], player2X, player2Y);
  if (A && player2X > 0) player2X -= player2V;
  else if (D && (player2X + player2W) < width) player2X += player2V; 
}

//Funções ball;
void ball() {
 if (preso) {
  ballX = catX + (catW/2);
  ballY = catY + (catH/2);
  vBallX = int(random(5, 8));
  vBallY = int(random(5, 8));
  if (random(0, 100) < 50) vBallX *= -1;
  else vBallX *= 1;
  if (random(0, 100) < 50) vBallY *= -1;
  else vBallY *= 1;
 } else {
   vBallY *= 1.0005;
   ballX += vBallX;
   ballY += vBallY;
   image(bolinha, (ballX-(ballW/2)), (ballY-(ballH/2)));
   //fill(255);
   //ellipse(ballX, ballY, ballW, ballH);
   if (lateral(ballX, ballW)) {
     pong.play(0);
     vBallX *= -1;
   }
   if (player(ballX, ballY, ballW, ballH, player1X, player1Y, player1W, player1H)) {
     pong.play(0);
     vBallY *= -1;
     vBallX = (ballX-(player1X+(player1W/2)))/10;
   }
   if (player(ballX, ballY, ballW, ballH, player2X, player2Y, player2W, player2H)) {
     pong.play(0);
     vBallY *= -1;
     vBallX = (ballX-(player2X+(player2W/2)))/10;
   }
   if (ballY - ballH/2 <= 0 || ballY + ballH/2 >= height) {
    if (ballY - ballH/2 <= 0) {
      //if (beepScore.isPlaying() != true) beepScore.play(0);
      score2 += 1;
    } else if (ballY + ballH/2 >= height) {
      //if (beepScore.isPlaying() != true) beepScore.play(0);
      score1 += 1;
    }
    ballX = width/2;
    ballY = height/2;
    vBallX = 0;
    if (random(0, 100) < 50) vBallY = 5;
    else vBallY = -5;
   }
   if (caixaAreia) {
     if (colisao(ballX, ballY, ballW, ballH, caixaAreiaX+10, caixaAreiaY+10, caixaAreiaW-20, caixaAreiaH-20)) {
      ballX = width/2;
      ballY = height/2;
     }
     if (colisao(ballX, ballY, ballW, ballH, caixaAreiaX, caixaAreiaY, caixaAreiaW, 10)) {
       pong.play(0);
       vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, caixaAreiaX, caixaAreiaY, 10, caixaAreiaH)) {
       pong.play(0);
       vBallX *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, caixaAreiaX, (caixaAreiaY+caixaAreiaH)-10, caixaAreiaW, 10)) {
       pong.play(0);
       vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, (caixaAreiaX+caixaAreiaW)-10, caixaAreiaY, 10, caixaAreiaH)) {
       pong.play(0);
       vBallX *= -1;
     }
   }
   if (pote) {
     if (colisao(ballX, ballY, ballW, ballH, poteX+10, poteY+10, poteW-20, poteH-20)) {
      ballX = width/2;
      ballY = height/2;
     }
     if (colisao(ballX, ballY, ballW, ballH, poteX, poteY, poteW, 10)) {
      pong.play(0);
      vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, poteX, poteY, 10, poteH)) {
       pong.play(0);
       vBallX *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, poteX, (poteY+poteH)-10, poteW, 10)) {
       pong.play(0);
       vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, (poteX+poteW)-10, poteY, 10, poteH)) {
       pong.play(0);
       vBallX *= -1;
     }
   }
   if (chinelos) {
     if (colisao(ballX, ballY, ballW, ballH, chinelosX+10, chinelosY+10, chinelosW-20, chinelosH-20)) {
      ballX = width/2;
      ballY = height/2;
     }
     if (colisao(ballX, ballY, ballW, ballH, chinelosX, chinelosY, chinelosW, 10)) {
      pong.play(0);
      vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, chinelosX, chinelosY, 10, chinelosH)) {
       pong.play(0);
       vBallX *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, chinelosX, (chinelosY+chinelosH)-10, chinelosW, 10)) {
       pong.play(0);
       vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, (chinelosX+chinelosW)-10, chinelosY, 10, chinelosH)) {
       pong.play(0);
       vBallX *= -1;
     }
   }
   if (caixaPapelao) {
     if (colisao(ballX, ballY, ballW, ballH, caixaPapelaoX+10, caixaPapelaoY+10, caixaPapelaoW-20, caixaPapelaoH-20)) {
      ballX = width/2;
      ballY = height/2;
     }
     if (colisao(ballX, ballY, ballW, ballH, caixaPapelaoX, caixaPapelaoY, caixaPapelaoW, 10)) {
      pong.play(0);
      vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, caixaPapelaoX, caixaPapelaoY, 10, caixaPapelaoH)) {
       pong.play(0);
       vBallX *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, caixaPapelaoX, (caixaPapelaoY+caixaPapelaoH)-10, caixaPapelaoW, 10)) {
       pong.play(0);
       vBallY *= -1;
     }
     if (colisao(ballX, ballY, ballW, ballH, (caixaPapelaoX+caixaPapelaoW)-10, caixaPapelaoY, 10, caixaPapelaoH)) {
       pong.play(0);
       vBallX *= -1;
     }
   }
 }
}


//FUNÇÃO DO CAT;
void cat() {
  if (dormindo != true) {
    if (catV > 0) {
      if (cat(ballX, ballY, ballW, ballH, (catX+40), catY, (catW-40), catH)) {
        if (miado) {
         meow1.play(0);
         miado = false;
       }
       image(animaBrincando(spriteGatoBrincando), catX, catY);
       timer[0]++;
       if (timer[0] >= 180) preso = false;
       else {
         miado = true;
         preso = true;
       }
       return; 
      }
      image(cat[1], catX, catY);
    } else {
      if (cat(ballX, ballY, ballW, ballH, catX, catY, (catW-40), catH)) {
       if (miado) {
         meow1.play(0);
         miado = false;
       }
       image(animaBrincando(spriteGatoBrincando), catX, catY);
       timer[0]++;
       if (timer[0] >= 180) preso = false;
       else {
         miado = true;
         preso = true;
       }
       return; 
      }
      image(cat[0], catX, catY);
    }
    if (limiteE(catX)) catV *= -1;
    else if (limiteD(catX, catW)) catV *= -1;
    
    if (timer[1] % 600 == 0) {
     if (random(0, 100) < 50) dormindo = true; 
    }
    catX += catV;
    timer[0] = 0;
  } else {
    image(animaDormindo(spriteGatoDormindo), catX, catY);
    if (cat(ballX, ballY, ballW, ballH, catX, catY, catW-31, catH)) {
     meow2.play(0);
     vBallY *= -1;
     dormindo = false;
    }
  }
}

//FUNÇÃO CAIXINHA;
void caixaAreia() {
 if (timer[1] >= 1800) {
  if (timer[1] == 1800) beepBarreiras.play(0);
  caixaAreia = true;
  image(caixaAreiaIMG, caixaAreiaX, caixaAreiaY);
 }
}

//FUNÇÃO POTE;
void pote() {
 if (timer[1] >= 1200) {
  if (timer[1] == 1200) beepBarreiras.play(0);
  pote = true;
  image(poteIMG, poteX, poteY);
 }
}

//FUNÇÃO CHINELOS;
void chinelos() {
 if (timer[1] >= 2400) {
  if (timer[1] == 2400) beepBarreiras.play(0);
  chinelos = true;
  image(chinelosIMG, chinelosX, chinelosY);
 } 
}

//FUNÇÃO CAIXA PAPELÃO;
void caixaPapelao() {
  if (timer[1] >= 3000) {
   if (timer[1] == 3000) beepBarreiras.play(0);
   caixaPapelao = true;
   image(caixaPapelaoIMG, caixaPapelaoX, caixaPapelaoY); 
  }
}

//FUNÇÃO SCORE;
void score() {
  String s1 = nf(score1, 2);
  String s2 = nf(score2, 2);
  textAlign(CENTER);
  textSize(78);
  fill(204, 51, 51);
  text(s1, 70, 100);
  fill(51, 153, 204);
  text(s2, 70, 600);
  fill(255);
  if (score1Atual != score1) {
   beepScore.play(0);
   score1Atual = score1;
  }
  if (score2Atual != score2) {
   beepScore.play(0);
   score2Atual = score2;
  }
}

//FUNÇÃO TEMPO;
void tempo() {
 int h = t / 60;
 int m = t % 60;
 String hora = nf(h, 2);
 String min = nf(m, 2);
 timer[2]++;
 if (t > 0) {
   if (timer[2] > 60) {
    t--;
    timer[2] = 0;
   }
 }
 textSize(48);
 textAlign(LEFT);
 text(hora + ":" + min, 10, (height/2) - 20);
}

//FUNÇÃO WIN;
void win() {
 if (score1 == 10 || score2 == 10 || (t <= 0 && score1 != score2)) gameScreen = 3;
 
}

//FUNÇÃO PREPARA JOGO;
void preparaJogo() {
  for (int i = 0; i < 2; i++) {
   timer[i] = 0; 
  }
  t = 180;
  preso = false;
  dormindo = false;
  caixaAreia = false;
  pote = false;
  chinelos = false;
  caixaPapelao = false;
  player1X = 450;
  player1W = 100;
  player2X = 450;
  player2W = 100;
  ballX = 500;
  ballY = 350;
  if (random(0, 100) > 50) vBallY = 5;
  else vBallY = -5;
  vBallX = 0;
  player1V = 10;
  player2V = 10;
  catX = 0;
  catY = (height/2) - 20;
  catV = 5;
  caixaAreiaX = random(width/2, (width-caixaAreiaW));
  caixaAreiaY = random((catY+catH), 500);
  //while (caixinhaY > (catY - caixinhaH) && caixinhaY < (catY+catH)) caixinhaY = random(100, 500);
  poteX = random(width/2, (width-poteW));
  poteY = random(100, (catY - poteH));
  //while (poteY > (catY - poteH) && poteY < (catY+catH)) poteY = random(100, 500);
  chinelosX = random(0, ((width/2)-chinelosW));
  chinelosY = random((catY+catH), 500);
  caixaPapelaoX = random(0, (width/2)-caixaPapelaoW);
  caixaPapelaoY = random(100, catY-caixaPapelaoH); 
  score1 = score2 = 0;
}

//Colisões;
boolean lateral(float x1, float w1) {
  if (x1 + w1/2 > width) return true;
  else if (x1 - w1/2 < 0) return true;
  else return false;
}
boolean player(float x1, float y1, float w1, float h1,  float x2, float y2, float w2, float h2) {
 if ((x1 + w1/2) < x2 || (x1 - w1/2) > (x2 + w2)) return false;
 else if ((y1 - h1/2) > (y2 + h2) || (y1 + h1/2) < y2) return false;
 else return true;
}
boolean cat(float x1, float y1, float w1, float h1,  float x2, float y2, float w2, float h2) {
 if ((x1 + w1/2) < x2 || (x1 - w1/2) > (x2 + w2)) return false;
 else if ((y1 - h1/2) > (y2 + h2) || (y1 + h1/2) < y2) return false;
 else return true;
}
boolean limiteE(float x) {
  if (x >= 0) return false;
  else return true;
}
boolean limiteD(float x, float w) {
 if (x + w <= width) return false;
 else return true;
}
boolean colisao(float x1, float y1, float w1, float h1,  float x2, float y2, float w2, float h2) {
 if (((x1-w1/2) + w1) < x2 || (x1-w1/2) > (x2 + w2)) return false;
 else if ((y1 - h1/2) > (y2 + h2) || ((y1-h1/2) + h1) < y2) return false;
 else return true;
}

//ANIMAÇÃO;
PImage animaBrincando(PImage spriteSheet) {
  PImage recorte = spriteSheet.get(quadro[0] * 121, 0, 121, 40);
  contador[0]++;
  if (contador[0] > 30) {
   contador[0] = 0;
   quadro[0]++;
   if (quadro[0] * 121 >= spriteSheet.width) quadro[0] = 0;
  }
  return recorte;
}
PImage animaDormindo(PImage spriteSheet) {
  PImage recorte = spriteSheet.get(quadro[1] * 109, 0, 109, 40);
  contador[1]++;
  if (contador[1] > 30) {
   contador[1] = 0;
   quadro[1]++;
   if (quadro[1] * 109 >= spriteSheet.width) quadro[1] = 0;
  }
  return recorte;
}