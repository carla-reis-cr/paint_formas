
void salvarDesenho() {
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(255);
  
  for (Forma f : formas) {
    pg.stroke(f.r, f.g, f.b);
    
    // Verifica se há preenchimento pela opacidade da cor
    if (alpha(f.corPreenchimento) > 0) {
      pg.fill(f.corPreenchimento);
    } else {
      pg.noFill();
    }
    
    switch(f.tipo) {
      case "quadrado":
        pg.rectMode(CORNERS);
        pg.rect(f.x1, f.y1, f.x2, f.y2);
        break;
      case "circulo":
        pg.ellipseMode(CORNERS);
        pg.ellipse(f.x1, f.y1, f.x2, f.y2);
        break;
      case "triangulo":
        float cx = (f.x1 + f.x2)/2;
        pg.triangle(cx, f.y1, f.x1, f.y2, f.x2, f.y2);
        break;
    }
  }
  
  pg.endDraw();
  String filename = "desenho_" + year() + nf(month(),2) + nf(day(),2) + "_" + 
                    nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png";
  pg.save(filename);
}
