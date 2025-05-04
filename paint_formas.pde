// Variáveis de controle
String formaAtual = "quadrado";
ArrayList<Forma> formas = new ArrayList<Forma>();

// Cores e sliders
Slider[] sliders = new Slider[3];
int[] cor = {0, 0, 0};

// Botões
Botao[] botoesFormas = new Botao[3];
Botao btnSalvar, btnLimpar;

// Constantes e controle de desenho
final int UI_TOP_HEIGHT = 60;
final int UI_BOTTOM_HEIGHT = 100;
int DRAWING_AREA_TOP, DRAWING_AREA_BOTTOM;
int inicioX, inicioY;
boolean desenhando = false;
long ultimoClique = 0;
final int INTERVALO_DUPLO_CLIQUE = 500; // 500ms para duplo clique

void setup() {
  size(800, 600);
  rectMode(CORNER);
  textSize(12);
  
  // Atualiza constantes dependentes do height
  DRAWING_AREA_TOP = UI_TOP_HEIGHT;
  DRAWING_AREA_BOTTOM = height - UI_BOTTOM_HEIGHT;
  
  // Inicializa sliders
  sliders[0] = new Slider(DRAWING_AREA_BOTTOM + 20, color(255, 0, 0), "R");
  sliders[1] = new Slider(DRAWING_AREA_BOTTOM + 40, color(0, 255, 0), "G");
  sliders[2] = new Slider(DRAWING_AREA_BOTTOM + 60, color(0, 0, 255), "B");
  
  // Inicializa botões de formas
  botoesFormas[0] = new Botao(30, 20, 40, 40, "quadrado");
  botoesFormas[1] = new Botao(90, 20, 40, 40, "circulo");
  botoesFormas[2] = new Botao(150, 20, 40, 40, "triangulo");
  btnSalvar = new Botao(300, 20, 70, 30, "Salvar");
  btnLimpar = new Botao(390, 20, 70, 30, "Limpar");
}

void draw() {
  background(255);
  
  // 1. Desenha formas na área permitida
  clipAreaDesenho();
  for (Forma f : formas) {
    f.desenhar();
  }
  resetClip(); // Remove o recorte
  
  // 2. Desenha interface (sem fundo branco)
  desenharUI();
  
  // 3. Pré-visualização do desenho (dentro da área)
  clipAreaDesenho();
  if (desenhando) {
    Forma preview = new Forma(
      inicioX, 
      inicioY, 
      constrain(mouseX, 0, width), 
      constrain(mouseY, DRAWING_AREA_TOP, DRAWING_AREA_BOTTOM), 
      formaAtual, 
      cor[0], 
      cor[1], 
      cor[2]
    );
    preview.desenhar();
  }
  resetClip();
}

void clipAreaDesenho() {
  // Define área de desenho válida
  noStroke();
  clip(0, DRAWING_AREA_TOP, width, DRAWING_AREA_BOTTOM - DRAWING_AREA_TOP);
}

void resetClip() {
  // Remove restrição de área
  noClip();
}
