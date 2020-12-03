// most of this is by Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/IKB1hWWedMk

import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myLocation;

int cols, rows;
import oscP5.*;
import netP5.*;

int scl = 20;
int w = 2000;
int h = 1600;

float flying = 0;

float[][] terrain;
int terrainHeight = 50;

int red, green, blue = 0;

void setup() {
  size(800, 800, P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  
  oscP5 = new OscP5(this, 12000);
  myLocation = new NetAddress("127.0.0.1", 12001);
}


void draw() {

  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -1 * (terrainHeight), terrainHeight);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  background(0);
  //default color is 255, 150, 0
  stroke(red, green, blue);
  fill(200, 0, 150);

  translate(width/2, height/2+50);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  println(theOscMessage.arguments());
  terrainHeight = int((theOscMessage.get(0).intValue()));
  red = theOscMessage.get(1).intValue();
  green = theOscMessage.get(2).intValue();
  blue = theOscMessage.get(3).intValue();
}
