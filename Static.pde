class Static {

  //Variables
  PVector p;
  float size;
  float fSize;
  float t;
  int state;
  boolean remove = false;
  boolean following = false;

  //Constructor
  Static(float x, float y) {
    //Picks a random size for the static
    fSize = random(30, 100);
    //Creates a new PVector for it's position
    p = new PVector(x, y);
    //Set its color mode to HSB
    colorMode(HSB, 360, 100, 100);
  }

  //Displays the static
  void display() {
    //Modify it's size according to the value of t
    size = easing(0, fSize, t, state);

    //Makes the static hollow if it's following the mouse and full if not
    if (!following) {
      fill(hue, 75, 50);
      noStroke();
    } else {
      fill(0);
      stroke(hue, 75, 50);
      strokeWeight(3);
    }
    
    circle(p.x, p.y, size);
  }

  //Updates the static
  void update() {
    //Makes it grow if the animation IN is on
    if (state == IN && t < 1) {
      t += 0.05;
    }

     //Makes it shrink if the animation OUT is on
    if (state == OUT) {
      if (t >= 0) {
        t -= 0.05;
      } else {
        //Indicates that the static can be removed
        remove = true;
      }
    }
  }

  //Sets the position of the static
  void setPosition(float x, float y) {
    p.x = x;
    p.y = y;
  }
}
