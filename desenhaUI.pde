void desenharUI() {
  
  // Fundo da interface
  fill(240);
  noStroke();
  rect(0, 0, width, UI_TOP_HEIGHT); // Barra superior
  rect(0, height - UI_BOTTOM_HEIGHT, width, UI_BOTTOM_HEIGHT); // Barra inferior
  
  // Botões de formas
  for (Botao btn : botoesFormas) {
    btn.desenhar(btn.id.equals(formaAtual) ? color(200) : color(255));
    btn.desenharSimbolo();
    if (btn.id.equals(formaAtual)) {
      stroke(0, 0, 255);
      noFill();
      rect(btn.x-2, btn.y-2, btn.w+4, btn.h+4);
    }
  }
  
  // Botões de controle
  btnSalvar.desenhar(color(200));
  btnLimpar.desenhar(color(200));
  
  // Sliders
  for (Slider s : sliders) {
    s.desenhar();
  }
  
  // Mostra cor atual
  fill(cor[0], cor[1], cor[2]);
  stroke(0);
  rect(width - 100, height - 80, 50, 50);
}
