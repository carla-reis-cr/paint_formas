class Botao {
  float x, y, w, h;
  String texto, id;
  
  Botao(float x, float y, float w, float h, String texto) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.texto = texto;
    this.id = texto.toLowerCase();
  }
  
  boolean mouseOver() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }
  
  void desenhar(color baseColor) {
    fill(baseColor);
    stroke(0);
    rect(x, y, w, h);
   
   
    // Remove o texto apenas para botões de formas
    if (!id.equals("quadrado") && !id.equals("circulo") && !id.equals("triangulo")) {
      fill(0);
      text(texto, x + 5, y + h/2 + 5);
    }
  }
  
  void desenharSimbolo() {
    stroke(0);
    noFill();
    switch(id) {
      case "quadrado":
        rect(x + w/4, y + h/4, w/2, h/2);
        break;
      case "circulo":
        ellipse(x + w/2, y + h/2, w/2, h/2);
        break;
      case "triangulo":
        triangle(x + w/2, y + h/4, x + w/4, y + 3*h/4, x + 3*w/4, y + 3*h/4);
        break;
    }
  }
}
