
// Classes auxiliares
class Slider {
  int x, y, valor, canal;
  String etiqueta;
  boolean arrastando = false;
  final int w = 200, h = 10;
  
  Slider(int y, color c, String etiqueta) {
    this.x = 30;
    this.y = y;
    this.etiqueta = etiqueta;
    this.canal = (c == color(255,0,0)) ? 0 : (c == color(0,255,0)) ? 1 : 2;
  }
  
  void atualizar(int mx) {
    valor = constrain((int)map(mx, x, x + w, 0, 255), 0, 255);
  }
  
  boolean mouseOver() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }
  
  void desenhar() {
    fill(0);
    text(etiqueta, 10, y + 10);
    fill(red(color(canal==0?255:0, canal==1?255:0, canal==2?255:0)), 
         green(color(canal==0?255:0, canal==1?255:0, canal==2?255:0)), 
         blue(color(canal==0?255:0, canal==1?255:0, canal==2?255:0)));
    rect(x, y, w, h);
    fill(0);
    ellipse(x + map(valor, 0, 255, 0, w), y + h/2, 15, 15);
  }
}
