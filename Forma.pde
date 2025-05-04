class Forma {
  int x1, y1, x2, y2, r, g, b;
  String tipo;
  color corPreenchimento;
  
  Forma(int x1, int y1, int x2, int y2, String tipo, int r, int g, int b) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.tipo = tipo;
    this.r = r;
    this.g = g;
    this.b = b;
    this.corPreenchimento = color(0, 0); // Transparente inicialmente
  }
  
  void togglePreenchimento(int r, int g, int b) {
    if (alpha(corPreenchimento) == 0) {
      corPreenchimento = color(r, g, b);
    } else {
      corPreenchimento = color(0, 0); // Remove preenchimento
    }
  }
  
  boolean contem(int x, int y) {
    int dx1 = constrain(this.x1, 0, width);
    int dy1 = constrain(this.y1, DRAWING_AREA_TOP, DRAWING_AREA_BOTTOM);
    int dx2 = constrain(this.x2, 0, width);
    int dy2 = constrain(this.y2, DRAWING_AREA_TOP, DRAWING_AREA_BOTTOM);
    
    switch(tipo) {
      case "quadrado":
        return x >= min(dx1, dx2) && x <= max(dx1, dx2) && 
               y >= min(dy1, dy2) && y <= max(dy1, dy2);
               
      case "circulo":
        float centroX = (dx1 + dx2)/2.0;
        float centroY = (dy1 + dy2)/2.0;
        float raio = dist(dx1, dy1, dx2, dy2)/2.0;
        return dist(x, y, centroX, centroY) <= raio;
        
      case "triangulo":
        float topoX = (dx1 + dx2)/2.0;
        float topoY = min(dy1, dy2);
        float baseY = max(dy1, dy2);
        if (y < topoY || y > baseY) return false;
        float progresso = map(y, topoY, baseY, 0, 1);
        return x >= lerp(topoX, min(dx1, dx2), progresso) && 
               x <= lerp(topoX, max(dx1, dx2), progresso);
      default: return false;
    }
  }
  
  void desenhar() {
    stroke(r, g, b);
    
    if (alpha(corPreenchimento) > 0) {
      fill(corPreenchimento);
      preencherForma();
    } else {
      noFill();
    }
    
    contornarForma();
  }
  
  void preencherForma() {
    int minX = min(x1, x2);
    int maxX = max(x1, x2);
    int minY = min(y1, y2);
    int maxY = max(y1, y2);
    
    switch(tipo) {
      case "quadrado":
        for (int y = minY; y <= maxY; y++) {
          line(minX, y, maxX, y);
        }
        break;
        
      case "circulo":
        int centroX = (x1 + x2)/2;
        int centroY = (y1 + y2)/2;
        int raio = (int)dist(x1, y1, x2, y2)/2;
        for (int ry = -raio; ry <= raio; ry++) {
          int dx = (int)sqrt(raio*raio - ry*ry);
          line(centroX - dx, centroY + ry, centroX + dx, centroY + ry);
        }
        break;
        
      case "triangulo":
        int topoX = (x1 + x2)/2;
        int topoY = min(y1, y2);
        int baseY = max(y1, y2);
        for (int y = topoY; y <= baseY; y++) {
          float p = map(y, topoY, baseY, 0, 1);
          int xEsq = (int)lerp(topoX, min(x1, x2), p);
          int xDir = (int)lerp(topoX, max(x1, x2), p);
          line(xEsq, y, xDir, y);
        }
        break;
    }
  }
  
  void contornarForma() {
    switch(tipo) {
      case "quadrado":
        line(x1, y1, x2, y1);
        line(x2, y1, x2, y2);
        line(x2, y2, x1, y2);
        line(x1, y2, x1, y1);
        break;
        
      case "circulo":
        int centroX = (x1 + x2)/2;
        int centroY = (y1 + y2)/2;
        int raio = (int)dist(x1, y1, x2, y2)/2;
        float px = centroX + raio;
        float py = centroY;
        for (float ang = 0; ang <= TWO_PI; ang += 0.1) {
          float x = centroX + raio * cos(ang);
          float y = centroY + raio * sin(ang);
          line(px, py, x, y);
          px = x;
          py = y;
        }
        break;
        
      case "triangulo":
        int topoX = (x1 + x2)/2;
        line(topoX, min(y1, y2), x1, max(y1, y2));
        line(topoX, min(y1, y2), x2, max(y1, y2));
        line(x1, max(y1, y2), x2, max(y1, y2));
        break;
    }
  }
}
