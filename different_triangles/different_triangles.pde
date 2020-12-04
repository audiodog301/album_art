int scl = 100;
int rows, columns;
void setup() {
  size(600, 600, P3D);
  rows = height / scl;
  columns = width / scl;
}

void draw() {
  //translate(0.5*height, 0.5*width);
  //rotateX(PI/3);
  for (int i = 0; i < columns; i++) {
    rect(i * scl, 0, 50, 50);
  }
}
