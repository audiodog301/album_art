import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myLocation;

int scl = 100;
int rows, columns;

int normalHeight = 0;
int secondHeight = 15;

int background = 1;

void setup() {
  size(600, 600, P3D);
  rows = height;
  columns = width / scl;
  
  oscP5 = new OscP5(this, 12000);
  myLocation = new NetAddress("127.0.0.1", 12001);
}

void draw() {
  if (background == 1) {
    background(120);
  }
  
  translate(width/2, height/2 + 50);
  rotateX(PI/3);
  translate(-width/2, (-height/2) - 300);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      if (j % 2 == 0 && i % 2 == 0) {
          translate(0, 0, normalHeight);
          rect(j * scl, i * scl, scl, scl);
          translate(0, 0, -normalHeight);
      } else {
          translate(0, 0, secondHeight);
          rect(j * scl, i * scl, scl, scl);
          translate(0, 0, -secondHeight);
      }
    }
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  normalHeight = int((theOscMessage.get(0).intValue()));
  secondHeight = int(theOscMessage.get(1).intValue());
  background = int(theOscMessage.get(2).intValue());
  scl = int(theOscMessage.get(3).intValue());
}
