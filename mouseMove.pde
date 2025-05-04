
void mousePressed() {
  // Verifica duplo clique
  long agora = millis();
  boolean duploClique = (agora - ultimoClique) < INTERVALO_DUPLO_CLIQUE;
  ultimoClique = agora;
  
  if (duploClique) {
    // Verifica clique em formas
    for (int i = formas.size()-1; i >= 0; i--) {
      Forma f = formas.get(i);
      if (f.contem(mouseX, mouseY)) {
         f.togglePreenchimento(cor[0], cor[1], cor[2]);
        return;
      }
    }
  }
  
  // Verifica outros elementos
  for (Botao btn : botoesFormas) {
    if (btn.mouseOver()) {
      formaAtual = btn.id;
      return;
    }
  }
  
  if (btnSalvar.mouseOver()) {
    salvarDesenho();
    return;
  }
  
  if (btnLimpar.mouseOver()) {
    formas.clear();
    return;
  }
  
  for (Slider s : sliders) {
    if (s.mouseOver()) {
      s.arrastando = true;
      return;
    }
  }
  
  // Inicia desenho
  if (mouseY > DRAWING_AREA_TOP && mouseY < DRAWING_AREA_BOTTOM) {
    inicioX = mouseX;
    inicioY = mouseY;
    desenhando = true;
  }
}

void mouseDragged() {
  // Atualiza sliders
  for (Slider s : sliders) {
    if (s.arrastando) {
      s.atualizar(mouseX);
      cor[s.canal] = s.valor;
    }
  }
}

void mouseReleased() {
  if (desenhando) {
    int x = constrain(mouseX, 0, width);
    int y = constrain(mouseY, DRAWING_AREA_TOP, DRAWING_AREA_BOTTOM);
    formas.add(new Forma(inicioX, inicioY, x, y, formaAtual, cor[0], cor[1], cor[2]));
    desenhando = false;
  }
  
  for (Slider s : sliders) {
    s.arrastando = false;
  }
}
