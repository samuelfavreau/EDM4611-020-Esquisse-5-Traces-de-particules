class Mobile {

  //Variables
  PVector p, acc, vel, gravity, speed;
  float size = 10;

  color mColor;

  int nbChild = 5;
  PVector[] child = new PVector[nbChild];

  //Constructor
  Mobile() {
    //Creates new PVectors for the position, the gravity and the velocity
    p = new PVector(random(width), -size);
    gravity = new PVector();
    vel = new PVector();

    //Creates a PVector for the acceleration that will be added to the velocity
    acc = new PVector(0, 1);
    acc.normalize();
    acc.mult(0.005);

    //Creates a PVector for the speed of the bounce
    speed = new PVector(0, 1);
    speed.normalize();

    //Creates an array to store the positions of the childs
    for (int i = 0; i < nbChild; i++) {
      child[i] = p.copy();
    }

    //Sets the color mode to HSB
    colorMode(HSB, 360, 100, 100);
  }

  //Displays the mobile
  void display() {
    //Makes the mobiles brightness proportionate to it's magnitude
    mColor = color(hue, map(gravity.mag(), 0, 26, 0, 100), 100);
    fill(mColor);
    noStroke();
    circle(p.x, p.y, size);
  }

  //Updates the mobile
  void update() {

    //Adds acceleration to the velocity and velocity to the gravity
    vel.add(acc);
    gravity.add(vel);

    //Slows down the speed of the bounce
    if (speed.mag() > 1) {
      speed.mult(0.99);
    }

    //Displays and updates the childs
    displayChilds();
    updateChilds();

    //Adds gravity and speed to the position
    p.add(gravity);
    p.add(speed);
  }

  //Displays the childs
  void displayChilds() {
    for (int i = 0; i < child.length; i++) {
      //Makes the size and the opacity gradually lower
      fill(mColor, map(i, 0, child.length, 100, 0));
      noStroke();
      circle(child[i].x, child[i].y, map(i, 0, child.length, size, size/10));
    }
  }

  //Updates the positions of the childs
  void updateChilds() {
    for (int i = child.length - 1; i >= 1; i--) {
      child[i] = child[i - 1];
    }
    child[0] = p.copy();
  }

  //Returns the position of the last child
  PVector getLastChild() {
    return child[nbChild - 1];
  }

  //Checks if the mobile has hit a static
  boolean collision(Static stat) {
    return (PVector.dist(p, stat.p) <= size/2 + stat.size/2);
  }

  //Makes the mobile bounce off a static
  void bounce(Static stat) {
    //Sets the speed to half of the current magnetude and removes the current gravity force
    speed.setMag(max(gravity.mag()/2, 2));
    vel.setMag(0.0);
    gravity.setMag(0.0);

    //Calculates the variables for the trigonometry
    float theta = PVector.sub(stat.p, p).heading();
    float sine = sin(theta);
    float cosine = cos(theta);

    //Pushes the mobile to the side of the static if they are inside on another
    if (PVector.dist(p, stat.p) < size/2 + stat.size/2) {
      PVector gitter = PVector.fromAngle(theta); 
      gitter.mult(-1);
      gitter.normalize();
      gitter.mult(((size/2 + stat.size/2) - PVector.dist(p, stat.p)) * 1.5);

      //Prevents the mobile from getting stuck bouncing of the same spot
      if (p.x < stat.p.x) {
        gitter.add(-0.5, 0);
      } else {
        gitter.add(0.5, 0);
      }

      p.add(gitter);
    }

    //Calculates the tengent of the static
    PVector teng = new PVector();
    teng.x = -(cosine * speed.x + sine * speed.y);
    teng.y = cosine * speed.y - sine * speed.x;

    //Calculates the new direction of the force
    PVector dir = new PVector();
    dir.x = cosine * teng.x - sine * teng.y;
    dir.y = cosine * teng.y + sine * teng.x;

    //Updates the speed force
    speed.x = dir.x;
    speed.y = dir.y;
  }
}
