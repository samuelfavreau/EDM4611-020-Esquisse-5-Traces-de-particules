int INOUT = 0;
int IN = 1;
int OUT = 2;

float easing(float start, float end, float t, int type) {
  float x = 0;
  if (type == INOUT) {
    x = bezierPoint(start, start, end, end, t);
  } else if (type == IN) {
    x = bezierPoint(start, start, start + (end - start)/2, end, t);
  } else if (type == OUT) {
    x = bezierPoint(start, start + (end - start)/2, end, end, t);
  }
  return x;
}
